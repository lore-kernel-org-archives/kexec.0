Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDuck-0002uK-Gp
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 10:34:03 +0000
Message-ID: <5139BE7F.5020905@zytor.com>
Date: Fri, 08 Mar 2013 02:33:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel
 to speedup kernel dump process
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <5139B827.3050500@hp.com>
In-Reply-To: <5139B827.3050500@hp.com>
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, yinghai@kernel.org, Vivek Goyal <vgoyal@redhat.com>

On 03/08/2013 02:06 AM, Jingbai Ma wrote:
> 
> Kernel do have some abilities that user space haven't. It's possible to
> map whole memory space of the first kernel into user space on the second
> kernel. But the user space code has to re-implement some parts of the
> kernel memory management system again. And worse, it's architecture
> dependent, more architectures supported, more codes have to be
> implemented. All implementation in user space must be sync to kernel
> implementation. It's may called "flexibility", but it's painful to
> maintain the codes.
> 

What?  You are basically talking about /dev/mem... there is nothing
particularly magic about it at all.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
