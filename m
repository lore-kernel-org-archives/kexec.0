Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8Eay-0000t4-MH
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 00:35:42 +0000
Date: Mon, 16 Apr 2018 18:35:22 -0600
From: Randy Wright <rwright@hpe.com>
Subject: Re: [PATCH] efi: Fix the size not consistent issue when unmapping
 memory map
Message-ID: <20180417003522.GA2741@rfwz>
References: <20180413062716.8040-1-jlee@suse.com>
 <20180416025734.GA26685@dhcp-128-65.nay.redhat.com>
 <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
 <20180416063738.GH16023@linux-l9pv.suse>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180416063738.GH16023@linux-l9pv.suse>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: rwright@hpe.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: joeyli <jlee@suse.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Apr 16, 2018 at 02:37:38PM +0800, joeyli wrote:
> Hi Randy,
> ...
> Randy, do you want to try Dave's kexec patch on your environment? Please remove
> my patch first.  
> 
> Thanks a lot!
> Joey Lee

Hi Joey, 

I tried Dave's patch to kexec-bzimage64.c on my build of the SuSE
4.12.14-15 kernel.   I ran the same test as I did with your patch: I
verified the early_ioremap.c warnings occurred with a crash triggered
from a kexec boot of the unmodified kernel. Then I applied the patch to
kexec-bzimage64.c, rebuilt, re-ran the test to crash from the kexec'ed
kernel, and verified the warnings are no longer seen.

I'm out of time today, but I will plan to run the same  test tomorrow on
a build of the SuSE 4.4.120-94.17 kernel, on which I had also reported
the original bug.

-- 
Randy Wright            Hewlett Packard Enterprise
Phone: (970) 898-0998   Mail: rwright@hpe.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
