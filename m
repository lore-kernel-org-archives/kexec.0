Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1gTJ-00G4i1-0Q
 for kexec@lists.infradead.org; Mon, 27 Dec 2021 03:14:50 +0000
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on kdump
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
 <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
 <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
 <Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <f4ca2296-f1fe-8836-9040-6025062f0a8b@igalia.com>
Date: Mon, 27 Dec 2021 00:14:05 -0300
MIME-Version: 1.0
In-Reply-To: <Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com>
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

On 26/12/2021 22:45, Dave Young wrote:
> On 12/25/21 at 04:21pm, Guilherme G. Piccoli wrote:
> [...] 
> Hi Guilherme, yes, I have the same concern.  But there could be more
> things like the panic_print in the future, it looks odd to have more
> kernel cmdline params though.
> 

Agreed! We're on the same page here, definitely.


> [...] 
> It is definitely a good idea, I'm more than glad to see this if you
> would like to work on this! 
> 

Awesome! I'll try to give it a shot this week, let's see how complex
that'd be.

Thanks again for the great feedback!
Cheers,


Guilherme




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
