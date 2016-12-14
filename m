Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHAK2-0005Ii-Eo
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 14:14:19 +0000
Received: by mail-pg0-f54.google.com with SMTP id f188so8618952pgc.3
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 06:13:57 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
 <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com> <58512A01.70101@arm.com>
 <20161214113701.GE17982@leverpostej>
 <3a6ac655-bfa6-0d90-6351-731ce36e99eb@redhat.com>
 <20161214134457.GJ17982@leverpostej>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <8a22f7bb-d0c4-8bda-4c2a-7a5c0b441a9b@redhat.com>
Date: Wed, 14 Dec 2016 19:43:50 +0530
MIME-Version: 1.0
In-Reply-To: <20161214134457.GJ17982@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: geoff@infradead.org, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org



On Wednesday 14 December 2016 07:14 PM, Mark Rutland wrote:
>> Even for the non-kdump ie `kexec -l` case we do not have a
>> > functionality to bypass sha verification in kexec-tools. --lite
>> > option with the kexec-tools was discouraged and not accepted.
> Ok. Do you have a pointer to the thread regarding that, for context?
>

https://lists.ozlabs.org/pipermail/petitboot/2015-October/000141.html
https://lists.ozlabs.org/pipermail/petitboot/2015-October/000136.html

~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
