Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aH34v-00051u-92
 for kexec@lists.infradead.org; Thu, 07 Jan 2016 05:25:41 +0000
Date: Thu, 7 Jan 2016 13:25:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Kexec_file_load failed with "Missing required AuthAttr"
Message-ID: <20160107052507.GA12900@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: David Howells <dhowells@redhat.com>
Cc: xlpang@redhat.com, kexec@lists.infradead.org, linux-crypto@vger.kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org

Hi,

I saw the warning "Missing required AuthAttr" when testing kexec, known issue?
Idea about how to fix it?

The kernel is latest linus tree plus sevral patches from Toshi to cleanup io resource structure.

in function pkcs7_sig_note_set_of_authattrs():
        if (!test_bit(sinfo_has_content_type, &sinfo->aa_set) ||
            !test_bit(sinfo_has_message_digest, &sinfo->aa_set) ||
            (ctx->msg->data_type == OID_msIndirectData &&
             !test_bit(sinfo_has_ms_opus_info, &sinfo->aa_set))) {
                pr_warn("Missing required AuthAttr\n");
                return -EBADMSG;
        }

The third condition below is true:
(ctx->msg->data_type == OID_msIndirectData &&
             !test_bit(sinfo_has_ms_opus_info, &sinfo->aa_set))

I signed the kernel with redhat test key like below:
pesign -c 'Red Hat Test Certificate' -i arch/x86/boot/bzImage -o /boot/vmlinuz-4.4.0-rc8+ -s --force

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
