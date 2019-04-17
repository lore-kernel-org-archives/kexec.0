Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGeb3-0003jt-QS
 for kexec@lists.infradead.org; Wed, 17 Apr 2019 07:03:07 +0000
Date: Wed, 17 Apr 2019 15:02:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190417070250.GD8411@dhcp-128-65.nay.redhat.com>
References: <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
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
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

On 04/16/19 at 10:44pm, Junichi Nomura wrote:
> On 4/16/19 6:40 PM, Borislav Petkov wrote:
> > On Mon, Apr 15, 2019 at 11:00:25PM +0000, Junichi Nomura wrote:
> >> I thought we should hang here instead of return so that we
> >> don't run into efi_get_rsdp_addr() in case of kexec.
> > 
> > Hanging that early without debug output is not very friendly to
> > debuggers, methinks.
> 
> Right. But if we could move get_rsdp_addr() after console_init(),
> you get debug output.
> 

move it after console_init looks better, I finally setup IME as a serial
console, I can see debug msg even for kexec reboot now.

How about move it after console_init, and at the same time skip
efi_get_rsdp_addr in case kexec?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
