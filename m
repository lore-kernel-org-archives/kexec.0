Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ec0Vr-0007jO-7x
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 03:05:12 +0000
Date: Thu, 18 Jan 2018 11:04:48 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
Message-ID: <20180118030448.GA7124@dhcp-128-65.nay.redhat.com>
References: <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
 <20180118014705.GA1812@dhcp-128-65.nay.redhat.com>
 <CA+55aFzc9eXKOdhS-ygQPbr0_N84d8iE8WbSGOWmpJXr1rvDjQ@mail.gmail.com>
 <47fe0d37-93d9-1394-062a-f973a38daa16@linux.intel.com>
 <20180118025702.GA2242@dhcp-128-65.nay.redhat.com>
 <CA+55aFxbkR+9dXu-ECm-Lx8bxpJhq=b60x_WdUS3XB9WzMp9=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFxbkR+9dXu-ECm-Lx8bxpJhq=b60x_WdUS3XB9WzMp9=w@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 01/17/18 at 07:00pm, Linus Torvalds wrote:
> On Wed, Jan 17, 2018 at 6:57 PM, Dave Young <dyoung@redhat.com> wrote:
> >
> > Could you say more about how to check this? My .config disabled
> > CONFIG_X86_MCE, should this be enabled?
> 
> By all means, try it.
> 
> Some pending machine check exception that we have *not* reacted to,
> and that is pending around kexec boot could very possibly be relevant.
> 
> I forget your exact symptoms. Was it that the _first_ kexec works, but
> the second one hangs? Or was that the other unrelated issue? Or have I
> confused this with some other report entirely?

Yes, 1st kexec works, 2nd hangs.

Rebuilding with MCE enabled now.

Thanks
Dave
> 
>                Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
