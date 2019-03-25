Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8OdH-0001yS-04
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 12:23:23 +0000
Date: Mon, 25 Mar 2019 20:23:02 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
References: <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190325120149.GI12016@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 03/25/19 at 01:01pm, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 10:36:33AM +0000, Junichi Nomura wrote:
> > AFAIU, early parsing is new code in v5.1-rc1 to support kexec on systems
> > with hotpluggable memory with KASLR enabled. For systems that requires the
> > new feature, it may be ok to say "you need to use another kexec interface"
> > and/or "you need new kexec-tools".
> 
> No, this exactly should *not* happen. kexec is already full of duct tape
> - don't need any more of that.
> 
> So I suggested that efi_get_rsdp_addr() should exit early on in the
> kexeced kernel but making this all play nice with the kexec-ed kernel,
> as Dave suggests, is better.
> 
> Now, my next question is: why does the RDSP address need to come from
> kexec(1) (by way of efi_setup_data) and why can't the kexec'ed kernel
> figure it out itself by parsing the EFI tables in a similar way to
> efi_get_rsdp_addr ?

efi_enter_virtual_mode() can only run once because of efi firmware/spec
limitation,  and after entered virtual mode, efi firmware just updated
the original efi sys table, for example the original
systab64->fw_vendor, systab64->tables, and even smbios (only found on
some HPE machine) are changed from physcial address to virtual address.

In the current efi_get_rsdp_addr, it assumes the efi config tables
address is not touched (as physical addresses), it will break then.

Kexec saved the original physical addresses, and pass them to kexeced
kernel via x86 setup_data, so  both the early parsing or efi init code
need to get those physical values from setup_data.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
