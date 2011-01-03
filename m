Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PZcXn-00010c-OL
	for kexec@lists.infradead.org; Mon, 03 Jan 2011 05:01:20 +0000
Date: Mon, 3 Jan 2011 10:31:09 +0530
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: How does kdump deal with trampoline allocation?
Message-ID: <20110103050109.GA3764@redhat.com>
References: <4D18F798.4010708@zytor.com> <20101228000651.GB4142@redhat.com>
	<4D192BC3.8040802@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D192BC3.8040802@zytor.com>
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
Cc: Yinghai Lu <yinghai@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Dec 27, 2010 at 04:13:55PM -0800, H. Peter Anvin wrote:
> On 12/27/2010 04:06 PM, Vivek Goyal wrote:
> > On Mon, Dec 27, 2010 at 12:31:20PM -0800, H. Peter Anvin wrote:
> >> Hi guys,
> >>
> >> I'm planning a major overhaul of the trampoline allocation in x86, and
> >> I'm trying to understand how kdump deals with it.  The trampoline has to
> >> be allocated in low memory (< 1 MiB) and obviously that doesn't include
> >> the kdump area at all.
> > 
> > Hi Peter,
> > 
> > Kdump has the concept of backup area. We backup the contents of first
> > 640KB of physical RAM in kdump reserved area and then allow kdump kernel
> > to use first 640KB of memory. So any trampoline allocation can be done
> > in low memory area without overwritting the contents of first kernel.
> > 
> 
> OK, that's straightforward.  That presumably means that the low 640K is
> marked unused in the memory map that memblock sees during early startup.

Yes, the available memory for second kernel is told to second kernel with
kernel command line option "memmap=", hence it should be visible to 
memblock and it should be able to allocate this memory.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
