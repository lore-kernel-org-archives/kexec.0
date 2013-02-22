Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22e.google.com ([2607:f8b0:4001:c02::22e])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8k0A-0000Nu-0L
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 04:12:50 +0000
Received: by mail-ia0-f174.google.com with SMTP id u20so207852iag.33
 for <kexec@lists.infradead.org>; Thu, 21 Feb 2013 20:12:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXUbEupR03v65gExrNwwzUQyCoQrMjh_UX-YHe3Zxb_2Q@mail.gmail.com>
References: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
 <20130125090818.GF30990@verge.net.au>
 <CAE9FiQWjj4GiBWqkCaR_hyXx8HjKrigk+erA2f9+Z7OUyC_e2w@mail.gmail.com>
 <20130128004913.GF3423@verge.net.au>
 <CAE9FiQXUbEupR03v65gExrNwwzUQyCoQrMjh_UX-YHe3Zxb_2Q@mail.gmail.com>
Date: Thu, 21 Feb 2013 20:12:48 -0800
Message-ID: <CAE9FiQUm4=GetjTqWvm+rem0zh2ebcd=Od7q0WVnuqhZovhLJw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] kexec: put bzImage and ramdisk above 4G for x86
 64bit
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sun, Jan 27, 2013 at 6:39 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sun, Jan 27, 2013 at 4:49 PM, Simon Horman <horms@verge.net.au> wrote:
>>> Do you want to wait those kexec-tools patches hit tip tree or Linus tree?
>>
>> Yes, if you could ping me when they hit Linus's tree that would be great.
>
> ok, will resend them after it hit Linus's tree.

Hi, Simon,

Kernel parts change get merged into linus' tree today via hpa.

I just resent kexec-tools parts, with v9 in the subject.

Please check them.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
