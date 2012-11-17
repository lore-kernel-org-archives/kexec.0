Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZcTy-0007JF-CA
 for kexec@lists.infradead.org; Sat, 17 Nov 2012 07:06:27 +0000
Received: by mail-ea0-f177.google.com with SMTP id n13so1348562eaa.36
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 23:06:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87haoo21mw.fsf@xmission.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
Date: Fri, 16 Nov 2012 23:06:23 -0800
Message-ID: <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] add mem64_min/max control
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Nov 16, 2012 at 10:18 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
>
>> So could limit range for 4g above buffers.
>
> What is wrong with mem-min and mem-max?  At this point in the patchset
> it looks like you are introducing mem64-min and mem64-max as a hack to
> avoid fixing mem-min and mem-max properly.

if we set mem-min high, some buffers for purgatory and real_mode can
not be allocated properly.

mem64-min and mem64-max are used to limit range for buffer that could
stay above 4g.
like limit them one range belong to one node only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
