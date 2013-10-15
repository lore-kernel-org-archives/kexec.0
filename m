Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x22c.google.com ([2607:f8b0:4001:c03::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVz67-0007gI-Qd
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 07:31:20 +0000
Received: by mail-ie0-f172.google.com with SMTP id tp5so109110ieb.31
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 00:30:55 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 15 Oct 2013 13:00:53 +0530
Message-ID: <CALicx6t6FA3U7_WLWaWj011CVxZjv_pe3aAbTnqbkF+ka-DiBA@mail.gmail.com>
Subject: ARM: Exynos: DTB too large error
From: Vijay Kilari <vijay.kilari@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

  While loading kexec kernel, with the below command,

kexec -l vmlinux --command-line="console=ttySAC2,115200n8 root=
/dev/nfs rw ip=dhcp nfsroot=xxxx...."

Error reported is:

DTB too large!
Cannot load /opt/vmlinux

The error is reported from below piece of code

int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
        struct kexec_info *info)
{
        unsigned long base;
        unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
        unsigned int offset = 0x8000;      /* 32k offset from memory start */

           .......
                if (base + atag_offset + dtb_length > base + offset) {
                        fprintf(stderr, "DTB too large!\n");
                        return -1;
                }

         ............
}

From zImage_arm_load() function as shown above in
kexec/arch/arm/kexec-zImage-arm.c file,
offset is hard-coded to 32K. However the dtb file of Exynos is more than
32K

Please let me reason behind 32K limit?

Thanks & Regards
Vijay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
