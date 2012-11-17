Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZpPg-00065O-JW
 for kexec@lists.infradead.org; Sat, 17 Nov 2012 20:54:53 +0000
Message-ID: <50A7F996.1030507@zytor.com>
Date: Sat, 17 Nov 2012 12:54:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <6eadd4ad-0e3f-4670-81a8-38beb9354e01@email.android.com>
 <CAE9FiQX8BD2VNnPXHnHYGowsS02czk3e+vLttuDpcaiZ3bDcLA@mail.gmail.com>
In-Reply-To: <CAE9FiQX8BD2VNnPXHnHYGowsS02czk3e+vLttuDpcaiZ3bDcLA@mail.gmail.com>
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

On 11/17/2012 12:51 PM, Yinghai Lu wrote:
> On Sat, Nov 17, 2012 at 12:41 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> Sorry, with "real mode" are we talking about struct boot_params or the actual realmode trampoline?  The latter needs to be < 640K as a hw requirement.
>
> boot_params.
>
> when kexec bzImage64, kexec will copy that from bzImage file, and
> update it....and
> pass pointer to arch/x86/boot/compressed/head_64.c via %rsi
>

Right, that's fine, of course.

We should make sure there aren't any implicit 32-bit assumptions 
there... there really shouldn't need to be.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
