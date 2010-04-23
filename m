Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O5752-0001au-NN
	for kexec@lists.infradead.org; Fri, 23 Apr 2010 00:49:17 +0000
Subject: Re: [PATCH 0/5] Add second memory region for crash kernel
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
	<m1aasvkupc.fsf@fess.ebiederm.org> <20100422224525.GJ3228@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Apr 2010 17:48:53 -0700
In-Reply-To: <20100422224525.GJ3228@redhat.com> (Vivek Goyal's message of
	"Thu\, 22 Apr 2010 18\:45\:25 -0400")
Message-ID: <m1eii7j8ne.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Vitaly Mayatskikh <v.mayatskih@gmail.com>, Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Apr 22, 2010 at 03:07:11PM -0700, Eric W. Biederman wrote:
>> Vitaly Mayatskikh <v.mayatskih@gmail.com> writes:
>> >
>> > This serie of patches realizes this approach. It requires also changes
>> > in kexec utility to make this feature work, but is
>> > backward-compatible: old versions of kexec will work with new
>> > kernel. I will post patch to kexec-tools upstream separately.
>> 
>> Have you tried loading a 64bit vmlinux directly into a higher address
>> range?  There may be a bit or two missing but you should be able to
>> load a linux kernel above 4GB.  I tested the basics of that mechanism
>> when I made the 64bit relocatable kernel.
>
> I guess even if it works, for distributions it will become additional
> liability to carry vmlinux (instead of relocatable bzImage). So we shall
> have to find a way to make bzImage work.

As Peter pointed out we actually have everything thing we need except
a bit of documentation and the flag that says this is a 64bit kernel.

From a testing perspective a 64bit vmlinux should work today without
changes.  Once it is confirmed there is a solution with the 64bit
kernel we just need a small patch to boot.txt and a few tweaks to 
/sbin/kexec to handle a 64bit bzImage.

>> I don't buy the argument that there is a direct connection between
>> the amount of memory you have and how much memory it takes to dump it.
>> Even an indirect connections seems suspicious.
>
> Memory requirement by user space might be of interest though like dump
> filtering tools. I vaguely remember that it used to first traverse all
> the memory pages, create some internal data structures and then start
> dumping.
>
> So memory required by filtering tool might be directly proportional to
> amount of memory present in the system.

Assuming your dump filtering tool creates a bitmap of pages to be dumped
you get a ration of 32K to 1.  Or 3MB for 100GB and 32MB for 1TB.
Which is noticeable in the worst case but definitely not enough to push
us past 2GB.

> Vitaly, have you really run into cases where 2G upper limit is a concern.
> What is the configuration you have, how much memory it has and how much
> memory are you planning to reserve for kdump kernel?

A good question.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
