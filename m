Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI3pD-0007Ol-0b
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 21:12:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040223.15064.77472.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 14:11:51 -0700
In-Reply-To: <20130316040223.15064.77472.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:02:23 +0900")
Message-ID: <87ppyvp014.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating
 the end of ELF note buffer
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

> Modern kernel marks the end of ELF note buffer with NT_VMCORE_PAD type
> note in order to make the buffer satisfy mmap()'s page-size boundary
> requirement. This patch makes finishing reading each buffer if the
> note type now being read is NT_VMCORE_PAD type.

Ick.  Even with a pad header you can mark the end with an empty header,
and my memory may be deceiving me but I believe an empty header is
specified by the ELF ABI docs.

Beyond which I don't quite see the point of any of this as all of these
headers need to be combined into a single note section before being
presented to user space.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
