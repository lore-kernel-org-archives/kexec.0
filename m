Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hC32a-0006go-5e
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 14:08:29 +0000
Date: Thu, 4 Apr 2019 22:08:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404140809.GA7789@dhcp-128-65.nay.redhat.com>
References: <20190403090210.GH1555@localhost.localdomain>
 <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
 <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
 <20190404030037.GT7627@MiWiFi-R3L-srv>
 <20190404031030.GU7627@MiWiFi-R3L-srv>
 <20190404032238.GA16267@dhcp-128-65.nay.redhat.com>
 <20190404064130.GA5530@dhcp-128-65.nay.redhat.com>
 <20190404072007.GL1555@localhost.localdomain>
 <20190404074102.GA5970@dhcp-128-65.nay.redhat.com>
 <20190404122255.GB22539@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404122255.GB22539@zn.tnic>
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
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/04/19 at 02:22pm, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 03:41:02PM +0800, Dave Young wrote:
> > It is hard to find 32bit efi hardware, I can confirm all the laptop I
> > have are 64bit efi.
> 
> You can use 32-bit OVMF with qemu, like in the link Chao gave a couple
> of mails earlier.

Since my case is not 32bit related, let me continue to get what happens
on 64bit laptops first.  32bit test can be done after that. 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
