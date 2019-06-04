Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hY9pD-0005Y9-34
 for kexec@lists.infradead.org; Tue, 04 Jun 2019 13:50:04 +0000
Date: Tue, 4 Jun 2019 21:49:52 +0800
From: Baoquan He <bhe@redhat.com>
Subject: The current SME implementation fails kexec/kdump kernel booting.
Message-ID: <20190604134952.GC26891@MiWiFi-R3L-srv>
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
To: Thomas.Lendacky@amd.com
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Tom,

Lianbo reported kdump kernel can't boot well with 'nokaslr' added, and
have to enable KASLR in kdump kernel to make it boot successfully. This
blocked his work on enabling sme for kexec/kdump. And on some machines
SME kernel can't boot in 1st kernel.

I checked code of SME implementation, and found out the root cause. The
above failures are caused by SME code, sme_encrypt_kernel(). In
sme_encrypt_kernel(), you get a 2M of encryption work area as intermediate
buffer to encrypt kernel in-place. And the work area is just after _end of
kernel.

This happens to work in 1st kernel. But it will fail kexec/kdump kernel
absolutely. Because we load realmode/kernel/initrd in kexec-tools from
top to down. In kexec-tools, realmode is put just after kernel image. If
KASLR enabled, kernel may be randomized to other position, then kdump
kernel can boot. However, if nokaslr specified, the 2M intermediate
encryption workarea will definitely stump into the following realmode,
and fail kexec/kdump kernel booting. 

I have hacked kexec-tools code to put real mode area 4M away from the
kernel image end, it works and confirm my finding. So the current SME
in-place encryption way is not only a kexec/kdump issue, but also an
issue in 1st kernel. Because KASLR could put kernel at the end of an
available memory region, how to make sure the next 2M intermediate
workarea must exist; if KASLR put kernel to be close to starting address
of any cmdline/initrd/setup_data, how to make sure the gap between them
must be larger than 2M.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
