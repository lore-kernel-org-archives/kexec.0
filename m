Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bVk-0005fs-Kc
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 15:20:53 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200814055239.47348-1-sangyan@huawei.com>
Date: Fri, 14 Aug 2020 10:17:06 -0500
In-Reply-To: <20200814055239.47348-1-sangyan@huawei.com> (Sang Yan's message
 of "Fri, 14 Aug 2020 01:52:38 -0400")
Message-ID: <87tux5i7f1.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
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
To: Sang Yan <sangyan@huawei.com>
Cc: luanjianhai@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, luchunhua@huawei.com, guohanjun@huawei.com, zhuling8@huawei.com

Sang Yan <sangyan@huawei.com> writes:

> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
> copy all segments from vmalloced memory to kernel boot memory,
> because of disabled mmu.

I haven't seen kexec that slow since I tested on my 16Mhz 386.

That machine has an excuse it really is slow.  Anything else
that takes seconds is almost certainly slow because someone
has misconfigured things to not cache the data copied by kexec.

I humbly suggest that you fix the arm64 code so that the data gets
cached.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
