Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj6NK-0006Xa-5F
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 12:59:50 +0000
Date: Tue, 28 Oct 2014 05:59:27 -0700
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V4] kernel, add bug_on_warn
Message-ID: <20141028125927.GG3274@tassilo.jf.intel.com>
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <20141028121636.GC3274@tassilo.jf.intel.com>
 <544F8A78.9070008@redhat.com> <20141028122900.GA10632@redhat.com>
 <20141028124425.GD3274@tassilo.jf.intel.com>
 <20141028125534.GC10632@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141028125534.GC10632@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, jason.wessel@windriver.com

> > kdb="on, bp warn_slowpath_common sr c, go" 
> 
> So does it already work or proposal is to make something like this work
> with kdb?

It does not work today, the missing pieces are: 

- extending kdb= to execute a list of kdb commands
- extending bp to define a list of commands to execute

> 
> What about the case of enabling it post boot and using a /sys file for 
> that.

This would be another patch, add a sysfs file to run a list of kdb commands.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
