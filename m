Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YqDNR-00040h-Hp
 for kexec@lists.infradead.org; Thu, 07 May 2015 04:25:38 +0000
Received: by pdea3 with SMTP id a3so29668686pde.3
 for <kexec@lists.infradead.org>; Wed, 06 May 2015 21:25:14 -0700 (PDT)
Message-ID: <554AE924.4040208@linaro.org>
Date: Thu, 07 May 2015 13:25:08 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 0/3] arm64: disable/enable d-cache support for
References: <cover.1430742915.git.panand@redhat.com>
 <1430931959.12082.12.camel@infradead.org> <554A5151.7020706@redhat.com>
In-Reply-To: <554A5151.7020706@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

Geoff, Pratyush

On 05/07/2015 02:37 AM, Pratyush Anand wrote:
> Hi Geoff,
>
> On Wednesday 06 May 2015 10:35 PM, Geoff Levand wrote:
>> Your 2 minutes seems like a long time.  Is this seen on other platforms?
>
> At least it is seen on two different HW platforms I had tested with. I do not know about other.
>
> It would be nice if somebody else who is using kexec on HW platform can report their execution time.

On my HW, it took about 42secs before showing extra boot messages after "I'm in purgatory."

-Takahiro AKASHI

> ~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
