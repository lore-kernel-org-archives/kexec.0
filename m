From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 10 May 2022 13:29:22 -0400
Subject: [PATCH 18/30] notifier: Show function names on notifier
 routines if DEBUG_NOTIFIERS is set
In-Reply-To: <9f44aae6-ec00-7ede-ec19-6e67ceb74510@huawei.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-19-gpiccoli@igalia.com>
 <9f44aae6-ec00-7ede-ec19-6e67ceb74510@huawei.com>
Message-ID: <20220510132922.61883db0@gandalf.local.home>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, 28 Apr 2022 09:01:13 +0800
Xiaoming Ni <nixiaoming@huawei.com> wrote:

> > +#ifdef CONFIG_DEBUG_NOTIFIERS
> > +	{
> > +		char sym_name[KSYM_NAME_LEN];
> > +
> > +		pr_info("notifiers: registered %s()\n",
> > +			notifier_name(n, sym_name));
> > +	}  
> 
> Duplicate Code.
> 
> Is it better to use __func__ and %pS?
> 
> pr_info("%s: %pS\n", __func__, n->notifier_call);
> 
> 
> > +#endif

Also, don't sprinkle #ifdef in C code. Instead:

	if (IS_ENABLED(CONFIG_DEBUG_NOTIFIERS))
		pr_info("notifers: regsiter %ps()\n",
			n->notifer_call);


Or define a print macro at the start of the C file that is a nop if it is
not defined, and use the macro.

-- Steve

