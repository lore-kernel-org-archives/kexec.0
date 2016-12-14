Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHJHP-0006OS-8i
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 23:48:11 +0000
Subject: Re: [PATCH 1/2] kexec: add a dummy note for each offline cpu
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
 <58510759.1080603@redhat.com>
 <CAFgQCTvFC92nXFYzpUs6fwbzeemDs1otDSW7j+iqyJ=3e-OACw@mail.gmail.com>
 <58510C87.7020209@redhat.com>
 <CAFgQCTvGn=FF01jeePRkGi09z3Yb0HxRqHM3MAX6F3AqZG8WqQ@mail.gmail.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <5851DA7B.5050106@redhat.com>
Date: Thu, 15 Dec 2016 07:49:15 +0800
MIME-Version: 1.0
In-Reply-To: <CAFgQCTvGn=FF01jeePRkGi09z3Yb0HxRqHM3MAX6F3AqZG8WqQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Liu ping fan <kernelfans@gmail.com>, xlpang@redhat.com
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>

On 12/14/2016 at 05:13 PM, Liu ping fan wrote:
> [...]
>>> No. This patch just place a mark on these offline cpu. The next patch
>>> for capture kernel will recognize this case, and ignore this kind of
>>> pt_note by the code:
>>> real_sz = 0; // although the size of this kind of PT_NOTE is not zero,
>>> but it contains nothing useful, so just ignore it
>>> phdr_ptr->p_memsz = real_sz
>> If there is any other vmcore functional issue besides throwing "Warning: Zero PT_NOTE entries found"?
>>
> Not at present when I debugged.

Well, agree that we should fix it given that it produces many unnecessary warnings on some machines.

> I just think we can not suppose the behaviour of different archs, so
> just mark out the dummy pt_note. If some archs want to use these notes
> memory,
> they will just overwrite the dummy.

For cpu crash_notes, it should be arch-independent, and related to elf format.

>
> Thx,
> Pingfan
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
