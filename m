Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0cmO-0005dZ-LQ
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 18:53:05 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de> <51094FD5.2070909@zytor.com>
Date: Wed, 30 Jan 2013 10:52:44 -0800
In-Reply-To: <51094FD5.2070909@zytor.com> (H. Peter Anvin's message of "Wed,
 30 Jan 2013 08:52:37 -0800")
Message-ID: <87obg6sdtv.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

"H. Peter Anvin" <hpa@zytor.com> writes:

> I have to admit to being rather confused as to the separation of various bits of
> kdump between the host kernel and various user-space components, but the whole
> use of the command line to pass the memory map seems just broken in light of
> everything that can go wrong.

It certainly seems time to look at this design decision and see if it
still makes sense.

The original idea was to pass the e820 map in the e820 variables, and to
slightly override that map to report which memory it was safe for the
kdump kernel to run in.  Leaving the kernel with the knowledge that
of where everything actually is, and that we just don't happen to be
using all of the memory.

Now something seems to have gone wrong with that strategy as we wound
up needing to play games with acpi and gart addresses.

I see one of two very basic options going forward.
- Pass a kernel command line option that just changes the kernels idea
  of which memory it can touch (and we can remove all of the other options).
- Modify the e820 map we pass to the kdump kernel and don't bother to
  pass anything on the command line.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
