Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8GYp-0006MD-J1
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 02:41:37 +0000
Date: Tue, 17 Apr 2018 10:41:12 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] efi: Fix the size not consistent issue when unmapping
 memory map
Message-ID: <20180417024112.GA3953@dhcp-128-65.nay.redhat.com>
References: <20180413062716.8040-1-jlee@suse.com>
 <20180416025734.GA26685@dhcp-128-65.nay.redhat.com>
 <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
 <20180416063738.GH16023@linux-l9pv.suse>
 <20180417003522.GA2741@rfwz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180417003522.GA2741@rfwz>
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
To: Randy Wright <rwright@hpe.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joeyli <jlee@suse.com>, "Lee,
 Chun-Yi" <joeyli.kernel@gmail.com>, akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 04/16/18 at 06:35pm, Randy Wright wrote:
> On Mon, Apr 16, 2018 at 02:37:38PM +0800, joeyli wrote:
> > Hi Randy,
> > ...
> > Randy, do you want to try Dave's kexec patch on your environment? Please remove
> > my patch first.  
> > 
> > Thanks a lot!
> > Joey Lee
> 
> Hi Joey, 
> 
> I tried Dave's patch to kexec-bzimage64.c on my build of the SuSE
> 4.12.14-15 kernel.   I ran the same test as I did with your patch: I
> verified the early_ioremap.c warnings occurred with a crash triggered
> from a kexec boot of the unmodified kernel. Then I applied the patch to
> kexec-bzimage64.c, rebuilt, re-ran the test to crash from the kexec'ed
> kernel, and verified the warnings are no longer seen.

Great, thanks for the testing, will send out the patch after some local
tests.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
