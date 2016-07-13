Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.windriver.com ([147.11.1.11])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNFve-0002KF-0t
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 08:54:02 +0000
From: Lans Zhang <jia.zhang@windriver.com>
Subject: [PATCH 1/2] PKCS#7: Fix kernel panic when referring to the empty
 AuthorityKeyIdentifier
Date: Wed, 13 Jul 2016 16:51:13 +0800
Message-ID: <1468399874-5880-1-git-send-email-jia.zhang@windriver.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: dhowells@redhat.com
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com

This fix resolves the following kernel panic if the empty AuthorityKeyIdentifier employed.

[  459.041989] PKEY: <==public_key_verify_signature() = 0
[  459.041993] PKCS7: Verified signature 1
[  459.041995] PKCS7: ==> pkcs7_verify_sig_chain()
[  459.041999] PKCS7: verify Sample DB Certificate for SCP: 01
[  459.042002] PKCS7: - issuer Sample KEK Certificate for SCP
[  459.042014] BUG: unable to handle kernel NULL pointer dereference at           (null)
[  459.042135] IP: [<ffffffff813e7b4c>] pkcs7_verify+0x72c/0x7f0
[  459.042217] PGD 739e6067 PUD 77719067 PMD 0
[  459.042286] Oops: 0000 [#1] PREEMPT SMP
[  459.042328] Modules linked in:
[  459.042368] CPU: 0 PID: 474 Comm: kexec Not tainted 4.7.0-rc7-WR8.0.0.0_standard+ #18
[  459.042462] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 10/09/2014
[  459.042586] task: ffff880073a50000 ti: ffff8800738e8000 task.ti: ffff8800738e8000
[  459.042675] RIP: 0010:[<ffffffff813e7b4c>]  [<ffffffff813e7b4c>] pkcs7_verify+0x72c/0x7f0
[  459.042784] RSP: 0018:ffff8800738ebd58  EFLAGS: 00010246
[  459.042845] RAX: 0000000000000000 RBX: ffff880076b7da80 RCX: 0000000000000006
[  459.042929] RDX: 0000000000000001 RSI: ffffffff81c85001 RDI: ffffffff81ca00a9
[  459.043014] RBP: ffff8800738ebd98 R08: 0000000000000400 R09: ffff8800788a304c
[  459.043098] R10: 0000000000000000 R11: 00000000000060ca R12: ffff8800769a2bc0
[  459.043182] R13: ffff880077358300 R14: 0000000000000000 R15: ffff8800769a2dc0
[  459.043268] FS:  00007f24cc741700(0000) GS:ffff880074e00000(0000) knlGS:0000000000000000
[  459.043365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  459.043431] CR2: 0000000000000000 CR3: 0000000073a36000 CR4: 00000000001006f0
[  459.043514] Stack:
[  459.043530]  0000000000000000 ffffffbf00000020 31ffffff813e68b0 0000000000000002
[  459.043644]  ffff8800769a2bc0 0000000000000000 00000000007197b8 0000000000000002
[  459.043756]  ffff8800738ebdd8 ffffffff81153fb1 0000000000000000 0000000000000000
[  459.043869] Call Trace:
[  459.043898]  [<ffffffff81153fb1>] verify_pkcs7_signature+0x61/0x140
[  459.043974]  [<ffffffff813e7f0b>] verify_pefile_signature+0x2cb/0x830
[  459.044052]  [<ffffffff813e8470>] ? verify_pefile_signature+0x830/0x830
[  459.044134]  [<ffffffff81048e25>] bzImage64_verify_sig+0x15/0x20
[  459.046332]  [<ffffffff81046e09>] arch_kexec_kernel_verify_sig+0x29/0x40
[  459.048552]  [<ffffffff810f10e4>] SyS_kexec_file_load+0x1f4/0x6c0
[  459.050768]  [<ffffffff81050e36>] ? __do_page_fault+0x1b6/0x550
[  459.052996]  [<ffffffff8199241f>] entry_SYSCALL_64_fastpath+0x17/0x93
[  459.055242] Code: e8 0a d6 ff ff 85 c0 0f 88 7a fb ff ff 4d 39 fd 4d 89 7d 08 74 45 4d 89 fd e9 14 fe ff ff 4d 8b 76 08 31 c0 48 c7 c7 a9 00 ca 81 <41> 0f b7 36 49 8d 56 02 e8 d0 91 d6 ff 4d 8b 3c 24 4d 85 ff 0f
[  459.060535] RIP  [<ffffffff813e7b4c>] pkcs7_verify+0x72c/0x7f0
[  459.063040]  RSP <ffff8800738ebd58>
[  459.065456] CR2: 0000000000000000
[  459.075998] ---[ end trace c15f0e897cda28dc ]---

Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 44b746e..13dcc97 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -227,8 +227,7 @@ static int pkcs7_verify_sig_chain(struct pkcs7_message *pkcs7,
 				if (asymmetric_key_id_same(p->id, auth))
 					goto found_issuer_check_skid;
 			}
-		} else {
-			auth = sig->auth_ids[1];
+		} else if ((auth = sig->auth_ids[1])) {
 			pr_debug("- want %*phN\n", auth->len, auth->data);
 			for (p = pkcs7->certs; p; p = p->next) {
 				if (!p->skid)
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
