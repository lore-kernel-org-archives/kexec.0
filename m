Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH v2 0/2] efi: arm64: Introduce /proc/efi/memreserve to tell the
 persistent pages
Date: Tue,  3 Dec 2019 15:14:08 -0500
Message-Id: <20191203201410.28045-1-msys.mizuma@gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masayoshi Mizuma <msys.mizuma@gmail.com>, d.hatayama@fujitsu.com

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

kexec reboot sometime fails in early boot sequence on aarch64 machine.
That is because kexec overwrites the LPI property tables and pending
tables with the initrd.

To avoid the overwrite, introduce /proc/efi/memreserve to tell the
tables region to kexec so that kexec can avoid the memory region to
locate initrd.

kexec also needs a patch to handle /proc/efi/memreserve. I'm preparing
the patch for kexec.

Changelog
    v2: - Change memreserve file location from sysfs to procfs.
          memreserve may exceed the PAGE_SIZE in case efi_memreserve_root
          has a lot of entries. So we cannot use sysfs_kf_seq_show().
          Use seq_printf() in procfs instead.

Masayoshi Mizuma (2):
  efi: add /proc/efi directory
  efi: arm64: Introduce /proc/efi/memreserve to tell the persistent
    pages

 drivers/firmware/efi/efi.c | 93 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

-- 
2.18.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
