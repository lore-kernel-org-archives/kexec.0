Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 21 Aug 2015 01:45:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V3 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20150820234500.GI3161@worktop.event.rightround.com>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.84120.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150806054543.25766.84120.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Aug 06, 2015 at 02:45:43PM +0900, Hidehiro Kawai wrote:
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index d05bd2e..dcd4038 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -231,7 +231,7 @@ void unregister_nmi_handler(unsigned int type, const char *name)
>  #endif
>  
>  	if (panic_on_unrecovered_nmi)
> -		panic("NMI: Not continuing");
> +		nmi_panic("NMI: Not continuing");
>  
>  	pr_emerg("Dazed and confused, but trying to continue\n");
>  

What tree is this again.. my tree (-tip) doesn't have
panic_on_unrecovered_nmi nonsense.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
