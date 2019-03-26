Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8lTB-0003ZA-US
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 12:46:23 +0000
Date: Tue, 26 Mar 2019 20:46:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190326124611.GA8143@dhcp-128-65.nay.redhat.com>
References: <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

On 03/25/19 at 11:10pm, Junichi Nomura wrote:
> On 3/25/19 9:32 PM, Borislav Petkov wrote:
> > On Mon, Mar 25, 2019 at 08:23:02PM +0800, Dave Young wrote:
> >> Kexec saved the original physical addresses, and pass them to kexeced
> >> kernel via x86 setup_data, so  both the early parsing or efi init code
> >> need to get those physical values from setup_data.
> > 
> > So efi_get_rsdp_addr() needs to be refactored in such a way so that at
> > least the loop towards the end gets carved out into a separate function
> > - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
> > size as arguments and finds the RSDP address in the kexec-ed kernel.
> 
> Since we still need to read systab for nr_tables and do signature
> check to determine if it's 32bit or 64bit for kexec-ed kernel,
> everything except the address of config_tables are common between
> normal boot and kexec boot.

Hmm, the efi/kexec support only added for 64bit, so no need check 32bit for
kexec.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
