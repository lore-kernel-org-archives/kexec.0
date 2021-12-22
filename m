Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n00pE-00AHqt-Ge
 for kexec@lists.infradead.org; Wed, 22 Dec 2021 12:34:33 +0000
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on kdump
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
Date: Wed, 22 Dec 2021 09:34:13 -0300
MIME-Version: 1.0
In-Reply-To: <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com, akpm@linux-foundation.org, feng.tang@intel.com, siglesias@igalia.com, kernel@gpiccoli.net, kexec@lists.infradead.org

On 22/12/2021 08:45, Dave Young wrote:
> Hi Guilherme,
> 
> Thanks for you patch.  Could you add kexec list for any following up
> patches?  This could change kdump behavior so let's see if any comments
> from kexec list.
> 
> Kudos for the lore+lei tool so that I can catch this by seeing this
> coming into Andrews tree :)

Hi Dave, I'm really sorry for not adding the kexec list, I forgot. But I
will do next time for sure, my apologies. And thanks for taking a look
after you noticed that on lore, I appreciate your feedback!

> [...]
> People may enable kdump crashkernel and panic_print together but
> they are not aware the extra panic print could cause kdump not reliable
> (in theory).  So at least some words in kernel-parameters.txt would
> help.
>  

That makes sense, I'll improve that in a follow-up patch, how about
that? Indeed it's a good idea to let people be sure that panic_print
might affect kdump reliability, although I consider the risk to be
pretty low. And I'll loop the kexec list for sure!

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
