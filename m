Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr80119.outbound.protection.outlook.com
 ([40.107.8.119] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbRuB-00016q-Tn
 for kexec@lists.infradead.org; Fri, 06 Jul 2018 14:40:18 +0000
Subject: Re: [PATCH 0/3] arm64: add support for loading kernel from FITimage
References: <1530795335-20867-1-git-send-email-arnaud.ferraris.external@sigfox.com>
 <CACi5LpP=aGG-aPe47e_xwqir_zhMpbQ+e7aTuB_Nn3CMDkEn2Q@mail.gmail.com>
From: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Message-ID: <598fab1c-3dbb-d11a-19e7-aa430509b1ee@sigfox.com>
Date: Fri, 6 Jul 2018 16:39:55 +0200
MIME-Version: 1.0
In-Reply-To: <CACi5LpP=aGG-aPe47e_xwqir_zhMpbQ+e7aTuB_Nn3CMDkEn2Q@mail.gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>

Hello Bhupesh,

Thanks for your answer.

On 06/07/2018 08:37, Bhupesh Sharma wrote:
> Hmm, I think I mentioned this earlier, but why do we need kexec to
> support the FIT image format? See the FIT image (or the .itb file)
> will be parsed by the u-boot bootloader and the respective components
> will be loaded by it at the appropriate load addresses (for the kernel
> Image it would be the load address mentioned in the 'loadaddr' u-boot
> environment variable and for the dtb it would be as per the arm64
> architecture dtb offset placement constraints).
>
> <...>
>
> So, I am trying to understand the use-case behind FIT image support in
> kexec. Do we need kexec-tools to be aware of the FIT format when the
> kernel itself it loaded in an uncompressed format (e.g. Image or
> vmlinux).

Ok, I'll do my best to explain our use case : U-boot indeed does a great
job at parsing and loading the FIT image components at the appropriate
addresses.

However, we use kexec (with option -p) to load a crash kernel to be executed
in case of a panic. Moreover, we need to load this kernel along with its own
dtb AND initrd (the initrd is very important, as it contains a special boot
script which uses makedumpfile to create a dump of the crashed kernel for
further analysis).

The FIT image we load through kexec is not necessarily the same as the one
we load through u-boot, the initrd being different, but the kernel and dtb
could be specific too.

All in all, this could be done by using a uImage for the kernel+dtb and a
separate initrd file, but this is not an option in our case, due to the
number of devices and architectures our build system supports, which is why
we need this FIT image support.

> If you can share your .its file and explain the use case better (may
> be with the u-boot logs) it would help in the review.

Sure, the .its file contents follow.

Best regards,

Arnaud

---
/dts-v1/;

/ {
         description = "U-Boot fitImage for SIGFOX TapOS/4.14.29+gitAUTOINC+8096079403/a3700";
         #address-cells = <1>;

         images {
                 kernel@1 {
                         description = "Linux kernel";
                         data = /incbin/("linux.bin");
                         type = "kernel";
                         arch = "arm64";
                         os = "linux";
                         compression = "gzip";
                         load = <0x00080000>;
                         entry = <0x00080000>;
                         hash@1 {
                                 algo = "sha256";
                         };
                 };
                 fdt@sigfox_sigfox-bs-a3700.dtb {
                         description = "Flattened Device Tree blob";
                         data = /incbin/("arch/arm64/boot/dts/sigfox/sigfox-bs-a3700.dtb");
                         type = "flat_dt";
                         arch = "arm64";
                         compression = "none";
                         load = <0x01800000>;
                         hash@1 {
                                 algo = "sha256";
                         };
                 };
                 ramdisk@1 {
                         description = "tapos-image-initramfs";
                         data = /incbin/(<path/to/initrd>);
                         type = "ramdisk";
                         arch = "arm64";
                         os = "linux";
                         compression = "gzip";
                         load = <0x02000000>;
                         entry = <0x02000000>;
                         hash@1 {
                                 algo = "sha256";
                         };
                 };
	};

         configurations {
                 default = "conf@sigfox_sigfox-bs-a3700.dtb";
                 conf@sigfox_sigfox-bs-a3700.dtb {
			description = "1 Linux kernel, FDT blob, ramdisk";
			kernel = "kernel@1";
			fdt = "fdt@sigfox_sigfox-bs-a3700.dtb";
			ramdisk = "ramdisk@1";
			
                         hash@1 {
                                 algo = "sha256";
                         };
                         signature@1 {
                                 algo = "sha256,rsa2048";
                                 key-name-hint = "kernel";
				sign-images = "kernel", "fdt", "ramdisk";
                         };
                 };
	};
};


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
