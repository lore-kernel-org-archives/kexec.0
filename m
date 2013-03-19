Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI4hJ-0007tL-SJ
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 22:07:58 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040121.15064.35279.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 15:07:47 -0700
In-Reply-To: <20130316040121.15064.35279.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:01:21 +0900")
Message-ID: <87hak7m4b0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 06/21] vmcore: round up buffer size of ELF headers by
 PAGE_SIZE
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> To satisfy mmap() page-size boundary requirement, round up buffer size
> of ELF headers by PAGE_SIZE. The resulting value becomes offset of ELF
> note segments and it's assigned in unique PT_NOTE program header
> entry.

Ok. That is just silly.  You can use a single buffer for the ELF header,
the program header and the notes.  It just requires a bit of counting
ahead of time.

The ELF header itself is small, and so are the program headers,
especially if you only have one PT_NOTE segment.  The only thing that
possibly gets big is the note segment, and then that only happens if you
have a lot of cpus.

Since there are entirely local constructs it seems extremely silly,
wasteful and complicated to place each logical part in a separately
mmapable buffer instead of placing them in the same mmapable buffer.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
