Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI64H-0005Yr-Ow
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 23:35:46 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040132.15064.42257.stgit@localhost6.localdomain6>
 <878v5jqf5e.fsf@xmission.com> <20130319212244.GE3872@redhat.com>
Date: Tue, 19 Mar 2013 16:35:36 -0700
In-Reply-To: <20130319212244.GE3872@redhat.com> (Vivek Goyal's message of
 "Tue, 19 Mar 2013 17:22:44 -0400")
Message-ID: <87boafhsjb.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/21] vmcore: copy non page-size aligned head and tail
 pages in 2nd kernel
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

Vivek Goyal <vgoyal@redhat.com> writes:

> Are you saying that some parts of the vmcore file will support mmap() and
> others will not. If yes, how would a user know which parts of file are
> mappable and which are not.

I think I answered this in another email in my review but I will
reanswer here.

There is absolutely no need to copy pages.  We can round up the mapping
to the nearest full page.  Mmap already does that today for files so it
isn't even odd.

Which only leaves the headers and notes as potentially unmmapable.  That
is more of a policy decision, and a decision on where we want to spend
memory.  Rounding ELF notes to mutliples of PAGE_SIZE from a perspective
of memory usage seems pretty terrible taking memory usage up an order of
magnitude.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
