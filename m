Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.syneticon.net ([213.239.212.131] helo=mail2.syneticon.net)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JNA5q-0005pS-4V
	for kexec@lists.infradead.org; Thu, 07 Feb 2008 16:59:28 +0000
Message-ID: <47AB38E2.9050509@wpkg.org>
Date: Thu, 07 Feb 2008 17:59:14 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: why kexec insists on syncing with recent kernels?
References: <47AB120A.1000600@wpkg.org> <20080207163752.GD11969@redhat.com>
In-Reply-To: <20080207163752.GD11969@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Horms <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>

Vivek Goyal schrieb:
> On Thu, Feb 07, 2008 at 03:13:30PM +0100, Tomasz Chmielewski wrote:
>> According to kernel/kexec.c:
>>
>>  * kexec does not sync, or unmount filesystems so if you need
>>  * that to happen you need to do that yourself.
>>
>>
> 
> In latest kexec code I do see it syncing. But it does not unmount the
> filesystems. So this comment looks like partially wrong.
> 
>> I saw this was true with 2.6.18 kernel (i.e., it didn't sync), but kexec 
>> syncs with recent kernels (I checked 2.6.23.14 and 2.6.24):
>>
>> # kexec -e
>> md: stopping all md devices
>> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> 
> Which kexec-tools you are using? 

# kexec -v
kexec 1.101 released 15 February 2005


> syncing is initiated by user space so changing kernel will not have
> any effect (as long as user space is same). I think just that message
> are spitted by kernel, so probably 2.6.18 did not spit any message and
> 2.6.24 does.

Yes and no.
I just booted 2.6.24 on a diskless system (Mandriva) I normally use with 
2.6.18 kernel, did kexec -e... And it executed the kernel immediately, 
without any syncing.
On Debian, with the same 2.6.24 kernel, it does sync.

So what user space part does the syncing (and how to prevent it)?

(...)


>> The way kexec works now makes rebooting unreliable again:
>> - network interfaces are brought down,
>> - kernel tries to sync - it never will, as we're booted off network, which 
>> is down
>>
> 
> Kexec has got an option -x --no-ifdown, which will not bring the network
> down. Try that. "kexec- -e -x"

It does seem to help, thanks.

Why it has to be the last option specified?

I tried -f option before (don't call shutdown), but it didn't help.


>> Any ideas why kexec insists on syncing?
> 
> To me it makes sense. Just making sure that cache changes make to the file
> system before you boot into new kernel.
> 
> In latest kexec-tools, I do see sync() is done first and then network
> interfaces are brought down. 
> 
> Try latest kexec tools from:
> 
> http://www.vergenet.net/~horms/linux/kexec/kexec-tools/testing/kexec-tools-testing-20071017-rc.tar.gz

Good to have a newer version, I'll try that, too.


-- 
Tomasz Chmielewski
http://wpkg.org


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
