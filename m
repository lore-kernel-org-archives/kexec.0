Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1OS-0005uE-GL
	for kexec@lists.infradead.org; Fri, 27 May 2011 18:04:17 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171521.GD17988@in.ibm.com>
Date: Fri, 27 May 2011 11:04:06 -0700
In-Reply-To: <20110526171521.GD17988@in.ibm.com> (K. Prasad's message of "Thu, 
	26 May 2011 22:45:21 +0530")
Message-ID: <m1fwo09g15.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch 4/6] PANIC_MCE: Introduce a new panic flag for fatal
	MCE, capture related information
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

> PANIC_MCE: Introduce a new panic flag for fatal MCE, capture related information
>
> Fatal machine check exceptions (caused due to hardware memory errors) will now
> result in a 'slim' coredump that captures vital information about the MCE. This
> patch introduces a new panic flag, and new parameters to *panic functions
> that can capture more information pertaining to the cause of crash.
>
> Enable a new elf-notes section to store additional information about the crash.
> For MCE, enable a new notes section that captures relevant register status
> (struct mce) to be later read during coredump analysis.

There may be a reason to pass everything struct mce through 5 layers of
code but right now it looks like it just makes everything uglier to no
real purpose.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
