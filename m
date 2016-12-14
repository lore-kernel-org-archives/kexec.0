Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH5Yz-00017o-Gy
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 09:09:26 +0000
Subject: Re: [PATCH 1/2] kexec: add a dummy note for each offline cpu
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
 <58510759.1080603@redhat.com>
 <CAFgQCTvFC92nXFYzpUs6fwbzeemDs1otDSW7j+iqyJ=3e-OACw@mail.gmail.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58510C87.7020209@redhat.com>
Date: Wed, 14 Dec 2016 17:10:31 +0800
MIME-Version: 1.0
In-Reply-To: <CAFgQCTvFC92nXFYzpUs6fwbzeemDs1otDSW7j+iqyJ=3e-OACw@mail.gmail.com>
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
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Pingfan Liu <piliu@redhat.com>, Baoquan He <bhe@redhat.com>

On 12/14/2016 at 04:56 PM, Liu ping fan wrote:
> On Wed, Dec 14, 2016 at 4:48 PM, Xunlei Pang <xpang@redhat.com> wrote:
>> On 12/14/2016 at 02:11 PM, Pingfan Liu wrote:
>>> kexec-tools always allocates program headers for each possible cpu. This
>>> incurs zero PT_NOTE for offline cpu. We mark this case so that later,
>>> the capture kernel can distinguish it from the mistake of allocated
>>> program header.
>>> The counterpart of the capture kernel comes in next patch.
>> Hmm, we can initialize the cpu crash note buf in crash_notes_memory_init(), needless
>> to do it at the crash moment, right?
>>
> The cpus can be on-off-on.., We can not know the user's action.

I meant we can add the fake note into the cpu note buf, then the crash happens, the online ones
will be overwritten with the real note data, while others(!online) will still be the fake note.

>
>> BTW, does this cause any issue, for example the crash utility can't parse the vmcore
>> properly? or just reproduce lots of warnings after offline multiple cpus?
>>
> No. This patch just place a mark on these offline cpu. The next patch
> for capture kernel will recognize this case, and ignore this kind of
> pt_note by the code:
> real_sz = 0; // although the size of this kind of PT_NOTE is not zero,
> but it contains nothing useful, so just ignore it
> phdr_ptr->p_memsz = real_sz

If there is any other vmcore functional issue besides throwing "Warning: Zero PT_NOTE entries found"?

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
