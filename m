Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbJoJ-0003rX-SJ
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 23:34:28 +0000
Message-ID: <50AD64FE.5080701@zytor.com>
Date: Wed, 21 Nov 2012 15:34:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121143729.GC13114@redhat.com>
 <CAE9FiQWRtMwXjUEr5pHtKKR+mPk7qtKRDpS_G_o=VzzKkBwL1Q@mail.gmail.com>
 <50AD31ED.3020202@zytor.com>
 <CAE9FiQXjH8nLQrPdP=OiXqROvhwf=mT8XOq9Netmsj08FXrEiw@mail.gmail.com>
 <50AD3685.3050702@zytor.com>
 <CAE9FiQWjWC59Vha8hfuSC6tRYgQ42ooA37UuOg4SP3_1Fzc5Tw@mail.gmail.com>
In-Reply-To: <CAE9FiQWjWC59Vha8hfuSC6tRYgQ42ooA37UuOg4SP3_1Fzc5Tw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 11/21/2012 12:47 PM, Yinghai Lu wrote:
>>>>
>>>> We should fix that limitation instead.
>>>
>>> sure, but that will make arch/x86/boot/compressed/head_64.S not need
>>> complicated.
>
> If that add cover cross GB boundary handling in head_64.S, may need
> another 100 line code
> for checking and etc.
>

That seems unlikely.

> Also will need another two spare pages for cross 512G boundary.

Doesn't seem like a problem.

Let me be blunt: either we do it right or we don't do it at all.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
