Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LUjoH-0005M6-GJ
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 15:37:08 +0000
References: <20090119212127.GA13157@hmsreliant.think-freely.org>
	<20090120141551.GA5125@redhat.com>
	<20090120150958.GB18207@hmsreliant.think-freely.org>
	<20090120152255.GB5125@redhat.com>
	<20090127001211.f847ea5a.akpm@linux-foundation.org>
	<20090128041109.GA4943@verge.net.au>
	<m1ljsnz1up.fsf@fess.ebiederm.org>
	<20090204120549.GA2182@hmsreliant.think-freely.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 04 Feb 2009 07:37:16 -0800
In-Reply-To: <20090204120549.GA2182@hmsreliant.think-freely.org> (Neil
	Horman's message of "Wed\, 4 Feb 2009 07\:05\:49 -0500")
Message-ID: <m1y6wmxlg3.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH]: add dmesg log symbols to /proc/vmcoreinfo lists
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Neil Horman <nhorman@tuxdriver.com> writes:

>> 
>> That aside we aren't currently exporting log_buf_len, so I don't
>> think this code works actually works.
>> 
>> Neil can you add a comment in kernel/printk.c of the algorithm
>> necessary for external tools to decode the ring buffer?
>> 
>> We need the comment because people working on kernel/printk.c
>> need to know what is happening and without having to review lots
>> of user space code, and we need the comment to verify that we
>> are exporting the right things.
>> 
>
> Ok, as per Erics comment, I've written this.  It applies on top of whats already
> in your tree Andrew.  It adds some comments on the function in question so that
> anyone working on printk.c will know why we're exporting their symbols.  It also
> modifies slightly the symbols we are exporting so that we can handle dmesg
> buffers that are longer than the standard PAGE_SIZE configuration, and lets us
> detect and handle buffer wraps.

Looks like a good start but what is the algorithm for using the variables?
Given a kernel core file how do you extract the dmesg ring buffer?

It still does not appear obvious to me that you are extracting the
dmesg ring buffer correctly or easily.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
