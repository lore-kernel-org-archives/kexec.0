Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DV-0000GJ-PB
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:16 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 3/8] kexec: new file openssl-1.1.0i.patch
Date: Mon, 14 Jan 2019 13:48:00 -0600
Message-Id: <1547495285-28907-4-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com

This patch creates a new file that is in turn a patch that contains a
small number of changes needed in order to soldier through the
compilation of all the OpenSSL sources within Xen.

This patch is applied to OpenSSL in xen.spec.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 openssl-1.1.0i.patch | 378 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)
 create mode 100644 openssl-1.1.0i.patch

diff --git a/openssl-1.1.0i.patch b/openssl-1.1.0i.patch
new file mode 100644
index 0000000..12ea07f
--- /dev/null
+++ b/openssl-1.1.0i.patch
@@ -0,0 +1,378 @@
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/aes/aes_locl.h xen/common/openssl-1.1.0i/crypto/aes/aes_locl.h
+--- /root/openssl-1.1.0i/crypto/aes/aes_locl.h	2018-08-14 08:45:06.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/aes/aes_locl.h	2018-11-12 17:59:01.885376275 -0500
+@@ -13,7 +13,7 @@
+ # include <openssl/e_os2.h>
+ # include <stdio.h>
+ # include <stdlib.h>
+-# include <string.h>
++# include <xen/string.h>
+ 
+ # if defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_AMD64) || defined(_M_X64))
+ #  define SWAP(x) (_lrotl(x, 8) & 0x00ff00ff | _lrotr(x, 8) & 0xff00ff00)
+@@ -25,12 +25,12 @@
+ # endif
+ 
+ # ifdef AES_LONG
+-typedef unsigned long u32;
++//typedef unsigned long u32;
+ # else
+-typedef unsigned int u32;
++//typedef unsigned int u32;
+ # endif
+-typedef unsigned short u16;
+-typedef unsigned char u8;
++//typedef unsigned short u16;
++//typedef unsigned char u8;
+ 
+ # define MAXKC   (256/32)
+ # define MAXKB   (256/8)
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/asn1/evp_asn1.c xen/common/openssl-1.1.0i/crypto/asn1/evp_asn1.c
+--- /root/openssl-1.1.0i/crypto/asn1/evp_asn1.c	2018-08-14 08:45:06.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/asn1/evp_asn1.c	2018-11-12 17:59:01.886376275 -0500
+@@ -56,7 +56,7 @@ ASN1_SEQUENCE(asn1_int_oct) = {
+         ASN1_SIMPLE(asn1_int_oct, oct, ASN1_OCTET_STRING)
+ } static_ASN1_SEQUENCE_END(asn1_int_oct)
+ 
+-DECLARE_ASN1_ITEM(asn1_int_oct)
++//DECLARE_ASN1_ITEM(asn1_int_oct)
+ 
+ int ASN1_TYPE_set_int_octetstring(ASN1_TYPE *a, long num, unsigned char *data,
+                                   int len)
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/asn1/n_pkey.c xen/common/openssl-1.1.0i/crypto/asn1/n_pkey.c
+--- /root/openssl-1.1.0i/crypto/asn1/n_pkey.c	2018-08-14 08:45:06.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/asn1/n_pkey.c	2018-11-12 17:59:01.886376275 -0500
+@@ -43,8 +43,8 @@ ASN1_BROKEN_SEQUENCE(NETSCAPE_ENCRYPTED_
+         ASN1_SIMPLE(NETSCAPE_ENCRYPTED_PKEY, enckey, X509_SIG)
+ } static_ASN1_BROKEN_SEQUENCE_END(NETSCAPE_ENCRYPTED_PKEY)
+ 
+-DECLARE_ASN1_FUNCTIONS_const(NETSCAPE_ENCRYPTED_PKEY)
+-DECLARE_ASN1_ENCODE_FUNCTIONS_const(NETSCAPE_ENCRYPTED_PKEY,NETSCAPE_ENCRYPTED_PKEY)
++//DECLARE_ASN1_FUNCTIONS_const(NETSCAPE_ENCRYPTED_PKEY)
++//DECLARE_ASN1_ENCODE_FUNCTIONS_const(NETSCAPE_ENCRYPTED_PKEY,NETSCAPE_ENCRYPTED_PKEY)
+ IMPLEMENT_ASN1_FUNCTIONS_const(NETSCAPE_ENCRYPTED_PKEY)
+ 
+ ASN1_SEQUENCE(NETSCAPE_PKEY) = {
+@@ -53,8 +53,8 @@ ASN1_SEQUENCE(NETSCAPE_PKEY) = {
+         ASN1_SIMPLE(NETSCAPE_PKEY, private_key, ASN1_OCTET_STRING)
+ } static_ASN1_SEQUENCE_END(NETSCAPE_PKEY)
+ 
+-DECLARE_ASN1_FUNCTIONS_const(NETSCAPE_PKEY)
+-DECLARE_ASN1_ENCODE_FUNCTIONS_const(NETSCAPE_PKEY,NETSCAPE_PKEY)
++//DECLARE_ASN1_FUNCTIONS_const(NETSCAPE_PKEY)
++//DECLARE_ASN1_ENCODE_FUNCTIONS_const(NETSCAPE_PKEY,NETSCAPE_PKEY)
+ IMPLEMENT_ASN1_FUNCTIONS_const(NETSCAPE_PKEY)
+ 
+ # endif                         /* OPENSSL_NO_RC4 */
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/bio/b_print.c xen/common/openssl-1.1.0i/crypto/bio/b_print.c
+--- /root/openssl-1.1.0i/crypto/bio/b_print.c	2018-08-14 08:45:06.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/bio/b_print.c	2018-11-12 17:59:01.887376275 -0500
+@@ -24,6 +24,7 @@
+ #ifdef HAVE_LONG_DOUBLE
+ # define LDOUBLE long double
+ #else
++#define double long
+ # define LDOUBLE double
+ #endif
+ 
+@@ -31,13 +32,18 @@ static int fmtstr(char **, char **, size
+                   const char *, int, int, int);
+ static int fmtint(char **, char **, size_t *, size_t *,
+                   int64_t, int, int, int, int);
++#if 0
+ static int fmtfp(char **, char **, size_t *, size_t *,
+                  LDOUBLE, int, int, int, int);
++#else
++#define fmtfp(A,B,C,D,E,F,G,H,I) fmtint(A,B,C,D,E,F,G,H,I)
++#endif
+ static int doapr_outch(char **, char **, size_t *, size_t *, int);
+ static int _dopr(char **sbuffer, char **buffer,
+                  size_t *maxlen, size_t *retlen, int *truncated,
+                  const char *format, va_list args);
+ 
++
+ /* format read states */
+ #define DP_S_DEFAULT    0
+ #define DP_S_FLAGS      1
+@@ -512,6 +518,7 @@ fmtint(char **sbuffer,
+     return 1;
+ }
+ 
++#if 0
+ static LDOUBLE abs_val(LDOUBLE value)
+ {
+     LDOUBLE result = value;
+@@ -798,6 +805,7 @@ fmtfp(char **sbuffer,
+     }
+     return 1;
+ }
++#endif
+ 
+ #define BUFFER_INC  1024
+ 
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/bn/bn_ctx.c xen/common/openssl-1.1.0i/crypto/bn/bn_ctx.c
+--- /root/openssl-1.1.0i/crypto/bn/bn_ctx.c	2018-08-14 08:45:06.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/bn/bn_ctx.c	2018-11-12 17:59:01.888376275 -0500
+@@ -9,6 +9,7 @@
+ 
+ #include "internal/cryptlib.h"
+ #include "bn_lcl.h"
++#undef current
+ 
+ /*-
+  * TODO list
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/bn/bn_dh.c xen/common/openssl-1.1.0i/crypto/bn/bn_dh.c
+--- /root/openssl-1.1.0i/crypto/bn/bn_dh.c	2018-08-14 08:45:06.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/bn/bn_dh.c	2018-11-12 17:59:01.889376275 -0500
+@@ -200,7 +200,7 @@ static const BN_ULONG dh2048_256_q[] = {
+ 
+ /* Macro to make a BIGNUM from static data */
+ 
+-# define make_dh_bn(x) extern const BIGNUM _bignum_##x; \
++# define make_dh_bn(x) /*extern const BIGNUM _bignum_##x;*/ \
+                        const BIGNUM _bignum_##x = { (BN_ULONG *) x, \
+                         OSSL_NELEM(x),\
+                         OSSL_NELEM(x),\
+Only in xen/common/openssl-1.1.0i/crypto: buildinf.h
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/cms/cms_lcl.h xen/common/openssl-1.1.0i/crypto/cms/cms_lcl.h
+--- /root/openssl-1.1.0i/crypto/cms/cms_lcl.h	2018-08-14 08:45:07.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/cms/cms_lcl.h	2018-11-12 17:59:01.889376275 -0500
+@@ -345,7 +345,7 @@ struct CMS_Receipt_st {
+     ASN1_OCTET_STRING *originatorSignatureValue;
+ };
+ 
+-DECLARE_ASN1_FUNCTIONS(CMS_ContentInfo)
++//DECLARE_ASN1_FUNCTIONS(CMS_ContentInfo)
+ DECLARE_ASN1_ITEM(CMS_SignerInfo)
+ DECLARE_ASN1_ITEM(CMS_IssuerAndSerialNumber)
+ DECLARE_ASN1_ITEM(CMS_Attributes_Sign)
+@@ -431,7 +431,7 @@ DECLARE_ASN1_ITEM(CMS_KeyTransRecipientI
+ DECLARE_ASN1_ITEM(CMS_OriginatorPublicKey)
+ DECLARE_ASN1_ITEM(CMS_OtherKeyAttribute)
+ DECLARE_ASN1_ITEM(CMS_Receipt)
+-DECLARE_ASN1_ITEM(CMS_ReceiptRequest)
++//DECLARE_ASN1_ITEM(CMS_ReceiptRequest)
+ DECLARE_ASN1_ITEM(CMS_RecipientEncryptedKey)
+ DECLARE_ASN1_ITEM(CMS_RecipientKeyIdentifier)
+ DECLARE_ASN1_ITEM(CMS_RevocationInfoChoice)
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/comp/c_zlib.c xen/common/openssl-1.1.0i/crypto/comp/c_zlib.c
+--- /root/openssl-1.1.0i/crypto/comp/c_zlib.c	2018-08-14 08:45:07.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/comp/c_zlib.c	2018-11-12 17:59:01.890376275 -0500
+@@ -17,7 +17,7 @@
+ #include "internal/bio.h"
+ #include "comp_lcl.h"
+ 
+-COMP_METHOD *COMP_zlib(void);
++//COMP_METHOD *COMP_zlib(void);
+ 
+ static COMP_METHOD zlib_method_nozlib = {
+     NID_undef,
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/cryptlib.c xen/common/openssl-1.1.0i/crypto/cryptlib.c
+--- /root/openssl-1.1.0i/crypto/cryptlib.c	2018-08-14 08:45:07.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/cryptlib.c	2018-11-12 17:59:01.891376275 -0500
+@@ -20,7 +20,7 @@
+         defined(__x86_64) || defined(__x86_64__) || \
+         defined(_M_AMD64) || defined(_M_X64)
+ 
+-extern unsigned int OPENSSL_ia32cap_P[4];
++//extern unsigned int OPENSSL_ia32cap_P[4];
+ 
+ # if defined(OPENSSL_CPUID_OBJ) && !defined(OPENSSL_NO_ASM) && !defined(I386_ONLY)
+ 
+Only in xen/common/openssl-1.1.0i/crypto/include/internal: bn_conf.h
+Only in xen/common/openssl-1.1.0i/crypto/include/internal: dso_conf.h
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/modes/modes_lcl.h xen/common/openssl-1.1.0i/crypto/modes/modes_lcl.h
+--- /root/openssl-1.1.0i/crypto/modes/modes_lcl.h	2018-08-14 08:45:07.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/modes/modes_lcl.h	2018-11-12 17:59:01.892376275 -0500
+@@ -19,12 +19,12 @@ typedef unsigned long u64;
+ # define U64(C) C##UL
+ #else
+ typedef long long i64;
+-typedef unsigned long long u64;
++//typedef unsigned long long u64;
+ # define U64(C) C##ULL
+ #endif
+ 
+-typedef unsigned int u32;
+-typedef unsigned char u8;
++//typedef unsigned int u32;
++//typedef unsigned char u8;
+ 
+ #define STRICT_ALIGNMENT 1
+ #ifndef PEDANTIC
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/o_time.c xen/common/openssl-1.1.0i/crypto/o_time.c
+--- /root/openssl-1.1.0i/crypto/o_time.c	2018-08-14 08:45:07.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/o_time.c	2018-11-12 17:59:01.892376275 -0500
+@@ -46,6 +46,12 @@ struct tm *OPENSSL_gmtime(const time_t *
+         return NULL;
+     ts = result;
+ #else
++#ifdef __XEN__
++    struct tm data, *ts2 = &data;
++    data = gmtime(*timer);
++    memcpy(result, ts2, sizeof(struct tm));
++    ts = ts2;
++#else
+     ts = gmtime(timer);
+     if (ts == NULL)
+         return NULL;
+@@ -53,6 +59,7 @@ struct tm *OPENSSL_gmtime(const time_t *
+     memcpy(result, ts, sizeof(struct tm));
+     ts = result;
+ #endif
++#endif
+     return ts;
+ }
+ 
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/crypto/rand/md_rand.c xen/common/openssl-1.1.0i/crypto/rand/md_rand.c
+--- /root/openssl-1.1.0i/crypto/rand/md_rand.c	2018-08-14 08:45:07.000000000 -0400
++++ xen/common/openssl-1.1.0i/crypto/rand/md_rand.c	2018-11-12 17:59:01.893376275 -0500
+@@ -45,6 +45,7 @@ static unsigned char state[STATE_SIZE + 
+ static unsigned char md[MD_DIGEST_LENGTH];
+ static long md_count[2] = { 0, 0 };
+ 
++#define double long
+ static double entropy = 0;
+ static int initialized = 0;
+ 
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/include/openssl/aes.h xen/common/openssl-1.1.0i/include/openssl/aes.h
+--- /root/openssl-1.1.0i/include/openssl/aes.h	2018-08-14 08:45:09.000000000 -0400
++++ xen/common/openssl-1.1.0i/include/openssl/aes.h	2018-11-12 17:59:01.893376275 -0500
+@@ -11,6 +11,7 @@
+ # define HEADER_AES_H
+ 
+ # include <openssl/opensslconf.h>
++#include <xen/types.h>
+ 
+ # include <stddef.h>
+ # ifdef  __cplusplus
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/include/openssl/e_os2.h xen/common/openssl-1.1.0i/include/openssl/e_os2.h
+--- /root/openssl-1.1.0i/include/openssl/e_os2.h	2018-08-14 08:45:09.000000000 -0400
++++ xen/common/openssl-1.1.0i/include/openssl/e_os2.h	2018-11-12 17:59:01.894376275 -0500
+@@ -233,14 +233,20 @@ extern "C" {
+ 
+ /* Standard integer types */
+ # if defined(OPENSSL_SYS_UEFI)
+-typedef INT8 int8_t;
+-typedef UINT8 uint8_t;
+-typedef INT16 int16_t;
+-typedef UINT16 uint16_t;
+-typedef INT32 int32_t;
+-typedef UINT32 uint32_t;
+-typedef INT64 int64_t;
+-typedef UINT64 uint64_t;
++#  include <stdint.h>
++//typedef int8_t INT8;
++//typedef uint8_t UINT8;
++//typedef int16_t INT16;
++//typedef uint16_t UINT16;
++//typedef int32_t INT32;
++//typedef uint32_t UINT32;
++//typedef int64_t INT64;
++//typedef uint64_t UINT64;
++#ifndef INTN
++typedef long INTN;
++#endif
++#define MAX_INTN 9223372036854775807L
++#define SIXTY_FOUR_BIT_LONG
+ # elif (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L) || \
+      defined(__osf__) || defined(__sgi) || defined(__hpux) || \
+      defined(OPENSSL_SYS_VMS) || defined (__OpenBSD__)
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/include/openssl/objects.h xen/common/openssl-1.1.0i/include/openssl/objects.h
+--- /root/openssl-1.1.0i/include/openssl/objects.h	2018-08-14 08:45:09.000000000 -0400
++++ xen/common/openssl-1.1.0i/include/openssl/objects.h	2018-11-12 17:59:01.895376276 -0500
+@@ -975,9 +975,10 @@ const void *OBJ_bsearch_ex_(const void *
+ 
+ # define _DECLARE_OBJ_BSEARCH_CMP_FN(scope, type1, type2, nm)    \
+   static int nm##_cmp_BSEARCH_CMP_FN(const void *, const void *); \
+-  static int nm##_cmp(type1 const *, type2 const *); \
+   scope type2 * OBJ_bsearch_##nm(type1 *key, type2 const *base, int num)
+ 
++/*  static int nm##_cmp(type1 const *, type2 const *); */
++
+ # define DECLARE_OBJ_BSEARCH_CMP_FN(type1, type2, cmp)   \
+   _DECLARE_OBJ_BSEARCH_CMP_FN(static, type1, type2, cmp)
+ # define DECLARE_OBJ_BSEARCH_GLOBAL_CMP_FN(type1, type2, nm)     \
+@@ -1021,8 +1022,7 @@ const void *OBJ_bsearch_ex_(const void *
+       { \
+       return (type2 *)OBJ_bsearch_(key, base, num, sizeof(type2), \
+                                         nm##_cmp_BSEARCH_CMP_FN); \
+-      } \
+-      extern void dummy_prototype(void)
++      }
+ 
+ # define IMPLEMENT_OBJ_BSEARCH_GLOBAL_CMP_FN(type1, type2, nm)   \
+   static int nm##_cmp_BSEARCH_CMP_FN(const void *a_, const void *b_)    \
+diff -x configdata.pm -x Makefile -rwbup /root/openssl-1.1.0i/include/openssl/ocsp.h xen/common/openssl-1.1.0i/include/openssl/ocsp.h
+--- /root/openssl-1.1.0i/include/openssl/ocsp.h	2018-08-14 08:45:09.000000000 -0400
++++ xen/common/openssl-1.1.0i/include/openssl/ocsp.h	2018-11-12 17:59:01.896376276 -0500
+@@ -92,7 +92,7 @@ typedef struct ocsp_resp_bytes_st OCSP_R
+ #  define V_OCSP_RESPID_KEY  1
+ 
+ DEFINE_STACK_OF(OCSP_RESPID)
+-DECLARE_ASN1_FUNCTIONS(OCSP_RESPID)
++//DECLARE_ASN1_FUNCTIONS(OCSP_RESPID)
+ 
+ typedef struct ocsp_revoked_info_st OCSP_REVOKEDINFO;
+ 
+@@ -159,8 +159,6 @@ int OCSP_REQ_CTX_i2d(OCSP_REQ_CTX *rctx,
+ int OCSP_REQ_CTX_nbio_d2i(OCSP_REQ_CTX *rctx, ASN1_VALUE **pval,
+                           const ASN1_ITEM *it);
+ BIO *OCSP_REQ_CTX_get0_mem_bio(OCSP_REQ_CTX *rctx);
+-int OCSP_REQ_CTX_i2d(OCSP_REQ_CTX *rctx, const ASN1_ITEM *it,
+-                     ASN1_VALUE *val);
+ int OCSP_REQ_CTX_http(OCSP_REQ_CTX *rctx, const char *op, const char *path);
+ int OCSP_REQ_CTX_set1_req(OCSP_REQ_CTX *rctx, OCSP_REQUEST *req);
+ int OCSP_REQ_CTX_add1_header(OCSP_REQ_CTX *rctx,
+Only in xen/common/openssl-1.1.0i/include/openssl: opensslconf.h
+Only in xen/common/openssl-1.1.0i: Makefile2
+Only in xen/common/openssl-1.1.0i/test: buildtest_aes.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_asn1.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_asn1t.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_bio.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_blowfish.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_bn.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_buffer.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_cmac.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_cms.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_comp.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_conf_api.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_conf.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_crypto.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_des.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_dh.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_ebcdic.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_e_os2.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_evp.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_hmac.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_kdf.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_lhash.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_md4.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_md5.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_modes.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_objects.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_obj_mac.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_ocsp.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_opensslv.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_ossl_typ.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_pem2.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_pem.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_pkcs12.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_pkcs7.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_rand.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_rc4.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_ripemd.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_rsa.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_safestack.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_sha.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_srtp.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_ssl2.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_ssl.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_stack.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_symhacks.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_tls1.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_txt_db.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_whrlpool.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_x509.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_x509v3.c
+Only in xen/common/openssl-1.1.0i/test: buildtest_x509_vfy.c
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
