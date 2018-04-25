Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fBDtz-0006Vj-2w
 for kexec@lists.infradead.org; Wed, 25 Apr 2018 06:27:42 +0000
Received: by mail-pg0-x241.google.com with SMTP id e9so12601886pgr.7
 for <kexec@lists.infradead.org>; Tue, 24 Apr 2018 23:27:28 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 09/11] include: pe.h: remove message[] from mz header
 definition
Date: Wed, 25 Apr 2018 15:26:27 +0900
Message-Id: <20180425062629.29404-10-takahiro.akashi@linaro.org>
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

message[] field won't be part of the definition of mz header.

This change is crucial for enabling kexec_file_load on arm64 because
arm64's "Image" binary, as in PE format, doesn't have any data for it and
accordingly the following check in pefile_parse_binary() will fail:

	chkaddr(cursor, mz->peaddr, sizeof(*pe));

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
---
 include/linux/pe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 143ce75be5f0..3482b18a48b5 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -166,7 +166,7 @@ struct mz_hdr {
 	uint16_t oem_info;	/* oem specific */
 	uint16_t reserved1[10];	/* reserved */
 	uint32_t peaddr;	/* address of pe header */
-	char     message[64];	/* message to print */
+	char     message[];	/* message to print */
 };
 
 struct mz_reloc {
-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
