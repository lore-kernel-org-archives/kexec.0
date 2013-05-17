Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UdBF5-0005er-RR
 for kexec@lists.infradead.org; Fri, 17 May 2013 03:22:05 +0000
Message-ID: <5195A223.2070204@zytor.com>
Date: Thu, 16 May 2013 20:21:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 0/8] kdump, vmcore: support mmap() on /proc/vmcore
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <51957469.2000008@zytor.com> <87y5bee2qc.fsf@xmission.com>
In-Reply-To: <87y5bee2qc.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, jingbai.ma@hp.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, vgoyal@redhat.com

On 05/16/2013 07:53 PM, Eric W. Biederman wrote:
> 
> That is completely and totally orthogonal to this change.
> 
> read_oldmem may have problems but in practice on a large systems those
> problems are totally dwarfed by real life performance issues that come
> from playing too much with the page tables.
> 
> I really don't find bringing up whatever foundational issues you have
> with read_oldmem() appropriate or relevant here.
> 

Well, it is in the sense that we have two pieces of code doing the same
thing, each with different bugs.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
