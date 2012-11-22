Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TbV89-0001Pe-1b
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 11:39:43 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121145023.GD13114@redhat.com>
 <CAE9FiQUHapB8_uGwMtM84xOHpMvWmVbn2Z8h0C=n_rfHPCbY_g@mail.gmail.com>
 <20121121200721.GI13114@redhat.com>
Date: Thu, 22 Nov 2012 03:39:12 -0800
In-Reply-To: <20121121200721.GI13114@redhat.com> (Vivek Goyal's message of
 "Wed, 21 Nov 2012 15:07:22 -0500")
Message-ID: <87624x27fj.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Wed, Nov 21, 2012 at 11:50:56AM -0800, Yinghai Lu wrote:
>> On Wed, Nov 21, 2012 at 6:50 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>> >
>> > So how do I force a 16bit or 32bit entry using a bzImage64?
>> 
>> kexec -t bzImage -l ....
>> will load low and use 32bit entry.
>> 
>> kexec -t bzImage64 -l ...
>> kexec -l ...
>> will try to load high and use 64bit entry.
>
> Also bzImage64 is not really a new image format. It is just enhancement
> of bzImage format. We keep on doing extention of bzImage and don't call it
> a new image format. I am not sure how good an idea it is to export the
> notion of new image type bzImage64 to user.

For what the loader has to do bzImage64 is effectively a new format,
and one way or another needs to be handled by separate functions so that
the code remains readable.

I asked YH to add the code that way because it means only a 64bit kexec
has to carry that code and we don't have 64bit dependencies in in the
32bit build that will break.  The code to prepare boot_params is still
shared.

Chaining to the 32bit loader if someone asks for --real-mode or
perhaps --entry32 seems quite reasonable and only a couple of lines
of code so I have not objections to that.

While development is on-going forcing the image type seems very
reasonable, but when the smoke clears I would like to see
the bzImage64 format chaining to bzImage for the cases it does not
handle.

But with respect to autodetection only having bzImage64 kick in when
loading a 64bit kernel is possible looks like the right way to go.

Eric




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
