Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VghmW-0005XK-Q6
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 21:15:25 +0000
Message-ID: <5283EBCD.6070305@zytor.com>
Date: Wed, 13 Nov 2013 13:14:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com>
 <20131113210432.GE7613@redhat.com>
In-Reply-To: <20131113210432.GE7613@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, linux kernel mailing list <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>, Baoquan He <bhe@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On 11/13/2013 01:04 PM, Vivek Goyal wrote:
> [CC hpa ]
> 
> And this issue brings me to the question that why do we allow sytem RAM
> ranges which do not start on page boundary or do not end on page boundary. 
> Can't we truncate the BIOS reported RAM ranges in such a way so that
> they start and end at PAGE boundary and rest of the kernel will never see
> unaligned portion of RAM and this will make life so much simpler for
> other tools.
> 

That is a bit of a headache for doing in the memblock space.  We do, in
fact, truncate partial pages, but later in the game.  It is possible we
should push that sooner in the stack.  The fact that it makes into the
rbtrees is fishy, but it also makes me wonder if we're doing something
totally stupid with regards to the memory mappings -- if this means
we're mapping ACPI data as noncacheable, that is not just a performance
problem but just plain wrong.  I don't even think the MTRRs can
represent different caching attributes for different parts of a page, so
this is something that we are doing.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
