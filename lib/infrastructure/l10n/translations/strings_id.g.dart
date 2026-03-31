///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsId with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsId _root = this; // ignore: unused_field

	@override 
	TranslationsId $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsId(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsGeneralId general = _TranslationsGeneralId._(_root);
	@override late final _TranslationsAuthId auth = _TranslationsAuthId._(_root);
	@override late final _TranslationsHomeId home = _TranslationsHomeId._(_root);
}

// Path: general
class _TranslationsGeneralId implements TranslationsGeneralEn {
	_TranslationsGeneralId._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Selamat Datang di Cleanser';
	@override String get submit => 'Kirim';
	@override String get cancel => 'Batal';
	@override String get loading => 'Memuat...';
	@override String get success => 'Berhasil';
	@override String get error => 'Terjadi kesalahan';
}

// Path: auth
class _TranslationsAuthId implements TranslationsAuthEn {
	_TranslationsAuthId._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Masuk';
	@override String get signUp => 'Daftar';
	@override String get forgotPassword => 'Lupa Sandi?';
	@override String get terms => 'Syarat & Ketentuan';
}

// Path: home
class _TranslationsHomeId implements TranslationsHomeEn {
	_TranslationsHomeId._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beranda';
	@override String get services => 'Layanan Kami';
	@override String get plan => 'Langganan';
	@override String get profile => 'Profil';
}

/// The flat map containing all translations for locale <id>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsId {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'general.welcome' => 'Selamat Datang di Cleanser',
			'general.submit' => 'Kirim',
			'general.cancel' => 'Batal',
			'general.loading' => 'Memuat...',
			'general.success' => 'Berhasil',
			'general.error' => 'Terjadi kesalahan',
			'auth.signIn' => 'Masuk',
			'auth.signUp' => 'Daftar',
			'auth.forgotPassword' => 'Lupa Sandi?',
			'auth.terms' => 'Syarat & Ketentuan',
			'home.title' => 'Beranda',
			'home.services' => 'Layanan Kami',
			'home.plan' => 'Langganan',
			'home.profile' => 'Profil',
			_ => null,
		};
	}
}
