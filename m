Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIZiC-0004J9-DK
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 07:14:57 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130319123005.46e48e3f154acf594da5737c@linux-foundation.org>
 <20130321.125245.142520187.d.hatayama@jp.fujitsu.com>
 <87d2ut2s7f.fsf@xmission.com>
 <20130321.153537.03532110.d.hatayama@jp.fujitsu.com>
Date: Thu, 21 Mar 2013 00:14:43 -0700
In-Reply-To: <20130321.153537.03532110.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Thu, 21 Mar 2013 15:35:37 +0900 (JST)")
Message-ID: <87d2utxlzw.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/21] kdump, vmcore: support mmap() on /proc/vmcore
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

> The breakage was caused by the introduction of new NT_VMCORE_PAD to
> "VMCOREINFO" name, except for which it worked fine. But it will be
> dropped in the next version. It'll be no problem for some time.
>
> The breakage was caused by makedumpfile itself due to the bug that it
> had so far seen note type only, not note name. It was possible to
> avoid the breakage by choosing another note name but I didn't do
> it. This topic will probably arise when some kind of new note types
> are needed.

Yes.  Not ignoring unknown note types is a a deficiency in makedumpfile.
And definitely not something to keep us from introducing new note types.

It should be noted that a common use of /proc/vmcore is to do:
cp /proc/vmcore /somepath/core

gdb /somepath/core

makedumpfile is just an optimization on that for people who want to
write a smaller file.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
