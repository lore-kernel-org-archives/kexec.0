Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1Lt-0005ss-N1
	for kexec@lists.infradead.org; Fri, 27 May 2011 18:01:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171251.GB17988@in.ibm.com>
Date: Fri, 27 May 2011 11:01:29 -0700
In-Reply-To: <20110526171251.GB17988@in.ibm.com> (K. Prasad's message of "Thu, 
	26 May 2011 22:42:51 +0530")
Message-ID: <m1lixs9g5i.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch 2/6] x86: mce: Convert mce code to xpanic
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: prasad@linux.vnet.ibm.com
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> commit aea29c4a9324f24b5c61e7c3919a8137a53be935
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Fri Nov 19 18:42:02 2010 +0100
>
>     x86: mce: Convert mce code to xpanic
>     
>     - Pass in the panic timeout directly instead of
>     abusing global variable.
>     - Disable backtraces and kexecs on machine check panics
>     because they don't do anything useful.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Kexec on panic does not fact do something useful, and usable
today.

The mce_panic_timeout looks like a horrible hack that should
be killed.  Why do we think we know better than the sysadmin
that sets up the system.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
