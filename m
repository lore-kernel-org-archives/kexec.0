Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH5ct-0004Gr-QC
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 09:13:29 +0000
Received: by mail-io0-x244.google.com with SMTP id b194so3567253ioa.3
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 01:13:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <58510C87.7020209@redhat.com>
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
 <58510759.1080603@redhat.com>
 <CAFgQCTvFC92nXFYzpUs6fwbzeemDs1otDSW7j+iqyJ=3e-OACw@mail.gmail.com>
 <58510C87.7020209@redhat.com>
From: Liu ping fan <kernelfans@gmail.com>
Date: Wed, 14 Dec 2016 17:13:06 +0800
Message-ID: <CAFgQCTvGn=FF01jeePRkGi09z3Yb0HxRqHM3MAX6F3AqZG8WqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kexec: add a dummy note for each offline cpu
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
To: xlpang@redhat.com
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Pingfan Liu <piliu@redhat.com>, Baoquan He <bhe@redhat.com>

[...]
>>>
>> No. This patch just place a mark on these offline cpu. The next patch
>> for capture kernel will recognize this case, and ignore this kind of
>> pt_note by the code:
>> real_sz = 0; // although the size of this kind of PT_NOTE is not zero,
>> but it contains nothing useful, so just ignore it
>> phdr_ptr->p_memsz = real_sz
>
> If there is any other vmcore functional issue besides throwing "Warning: Zero PT_NOTE entries found"?
>
Not at present when I debugged.
I just think we can not suppose the behaviour of different archs, so
just mark out the dummy pt_note. If some archs want to use these notes
memory,
they will just overwrite the dummy.

Thx,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
