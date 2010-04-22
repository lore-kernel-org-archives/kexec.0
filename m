Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O555J-00049C-53
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 22:41:26 +0000
Message-ID: <4BD0CFC1.2060907@zytor.com>
Date: Thu, 22 Apr 2010 15:37:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] Add second memory region for crash kernel
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
	<m1aasvkupc.fsf@fess.ebiederm.org>
In-Reply-To: <m1aasvkupc.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vitaly Mayatskikh <v.mayatskih@gmail.com>, Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

On 04/22/2010 03:07 PM, Eric W. Biederman wrote:
> 
> Have you tried loading a 64bit vmlinux directly into a higher address
> range?  There may be a bit or two missing but you should be able to
> load a linux kernel above 4GB.  I tested the basics of that mechanism
> when I made the 64bit relocatable kernel.
> 
> I don't buy the argument that there is a direct connection between
> the amount of memory you have and how much memory it takes to dump it.
> Even an indirect connections seems suspicious.
> 

We actually have a 64-bit entry point even in bzImage; it is at offset
+0x200 from the 32-bit entry point.  Right now that offset is not
exported anywhere, but it has been stable for a very long time... at
least for as far back as the decompressor has been 64 bits.

The interface to the 64-bit code is by necessity wider, since there is
no such thing as paging off in 64-bit mode, but it probably isn't *too*
hard to figure out how page tables need to be set up in order to work
properly.  At that point, it would be good to document it.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
