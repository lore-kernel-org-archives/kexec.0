Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dckYZ-0004iM-F9
 for kexec@lists.infradead.org; Wed, 02 Aug 2017 03:42:50 +0000
Received: by mail-pg0-f42.google.com with SMTP id y129so15913896pgy.4
 for <kexec@lists.infradead.org>; Tue, 01 Aug 2017 20:42:25 -0700 (PDT)
Subject: Re: [PATCH] makedumpfile: x86: Take care of init_level4_pgt rename in
 kernel
From: Pratyush Anand <panand@redhat.com>
References: <b5a4b87480473137478313355b0a6fd9f197f945.1501432848.git.panand@redhat.com>
 <20170731023838.GA7947@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EF57F4@BPXM01GP.gisp.nec.co.jp>
 <5d126fad-5ccf-7fd8-1bf2-29675ac0d75e@redhat.com>
 <03231128-333a-7c06-b3b9-9f7056af65be@redhat.com>
Message-ID: <fdc5c718-197f-2dae-c8f5-e98c0148b3aa@redhat.com>
Date: Wed, 2 Aug 2017 09:12:20 +0530
MIME-Version: 1.0
In-Reply-To: <03231128-333a-7c06-b3b9-9f7056af65be@redhat.com>
Content-Language: en-US
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Tuesday 01 August 2017 01:48 PM, Pratyush Anand wrote:
>>>
>>> I think what you want to do is like commit: ed46b6ad9, but I don't want to
>>> introduce a new flag every time a symbol name is changed. So how about
>>> unification into "init_level4_pgt" for backward compatibility ?
>>> The old name can be read in all versions of makedumpfile.
>>
> 
> Still not sure, it it will be a good idea to have  "init_level4_pgt" in newer 
> generated vmcoreinfo ...

So, what is the suggestion?
Introduce a new variable like commit: ed46b6ad9 or keep symbol of 
"init_level4_pgt" in generated vmcoreinfo for all kernels?

-- 
Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
