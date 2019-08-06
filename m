Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1huvGV-0006ec-DZ
 for kexec@lists.infradead.org; Tue, 06 Aug 2019 08:56:20 +0000
Date: Tue, 6 Aug 2019 16:56:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [LKP] [x86/boot] 5b51ae969e: kexec boot failed
Message-ID: <20190806085611.GA2671@dhcp-128-65.nay.redhat.com>
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802093024.GB30710@zn.tnic>
 <0f817336-2d87-2110-13c0-e0a417d70e90@intel.com>
 <20190805130221.GA18887@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190805130221.GA18887@zn.tnic>
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
To: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "Chen, Rong A" <rong.a.chen@intel.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, lkp@01.org

On 08/05/19 at 03:02pm, Borislav Petkov wrote:
> On Mon, Aug 05, 2019 at 07:49:54PM +0800, Chen, Rong A wrote:
> > We use the following command to boot a new kernel:
> > kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.6/gcc-7/5b51ae969e3d8ab0134ee3c98a769ad6d2cc2e24/vmlinuz-5.2.0-rc3-00004-g5b51ae969e3d8a
> > --initrd=/opt/rootfs/tmp/initrd-concatenated
> 
> And this "concatenated" initrd, how do you generate that?
> 
> FWIW, trying this in a vm doesn't seem to work because of EFI even though
> --noefi is supplied on the cmdline:
> 
> $ kexec --noefi -l /mnt/tmp/bzImage
> Unknown type (Reserved) while parsing /sys/firmware/memmap/5/type. Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/1/type. Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/6/type. Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/4/type. Please report this as bug. Using RANGE_RESERVED now.
> Unknown type (Reserved) while parsing /sys/firmware/memmap/2/type. Please report this as bug. Using RANGE_RESERVED now.

These warning messages should have been fixed in latest kexec-tools
since 2017.  e820 (/proc/iomem) previously used "reserved", later
changed to "Reserved" thus kexec-tools can not recognize.

I would suggest you also upgrade to latest kexec-tools, but this should
be not harmful since it is still using those ranges as reserved..

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
