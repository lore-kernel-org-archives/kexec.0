Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0QQe-0000b4-4e
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 05:41:48 +0000
In-Reply-To: <20130130043100.GO28230@verge.net.au>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <20130130043100.GO28230@verge.net.au>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Make use of new memmap= kernel parameter syntax
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 29 Jan 2013 23:40:46 -0600
Message-ID: <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
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
To: Simon Horman <horms@verge.net.au>, Thomas Renninger <trenn@suse.de>
Cc: yinghai@kernel.org, x86@kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com

The right thing to do as I have discussed with the people involved is to modify the memory map data structure to have a new memory type ID for memory which is to be dumped.  That eliminates the need to put all this info into the command line.

Simon Horman <horms@verge.net.au> wrote:

>On Tue, Jan 22, 2013 at 04:02:12PM +0100, Thomas Renninger wrote:
>> Details were discussed on quite some lists (kexec, lkml, x86, etc)
>> in a kernel thread with subject:
>> [PATCH] x86 e820: only void usable memory areas in memmap=exactmap
>case
>> 
>> The patch that memmap= can take several arguments is already queued
>> in linux-x86-tip in the mm2 branch.
>> 
>> There have been no objections on the introduction to
>memmap=resetusablemap
>> for several days after discussing things in detail. The repost
>patches
>> (will do that now) propably will show up in x86-tip mainline kernel
>> tree pretty soon as well.
>> Target for this feature to show up in Linus' tree is 3.9-rc1.
>> Therefore these patches check for 3.9.0 and newer kernels. If such a
>> kernel is tried to get loaded via kexec -p, the new memmap= syntax is
>used.
>> 
>> Please consider to apply these to the kexec-tools repository.
>
>Hi Thomas,
>
>could I check that the status of these patches is still as you describe
>above?

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
