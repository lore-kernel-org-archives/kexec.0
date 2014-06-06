Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-we0-x229.google.com ([2a00:1450:400c:c03::229])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsmyI-0003Bn-OD
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 05:45:47 +0000
Received: by mail-we0-f169.google.com with SMTP id q58so2057714wes.14
 for <kexec@lists.infradead.org>; Thu, 05 Jun 2014 22:45:23 -0700 (PDT)
Message-ID: <5391556D.6090204@gmail.com>
Date: Fri, 06 Jun 2014 07:45:17 +0200
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in kernel
 loading
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140604092214.GA17528@dhcp-17-89.nay.redhat.com>
 <20140604175031.GA4406@redhat.com>
 <CAHO5Pa0dxpq7YNe5eUMPE9Mn5m7XCnB1C5mZxrvt2-OqOpVZAA@mail.gmail.com>
 <20140605140416.GB17389@redhat.com>
In-Reply-To: <20140605140416.GB17389@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linux API <linux-api@vger.kernel.org>, dyoung@redhat.com, WANG Chao <chaowang@redhat.com>, mtk.manpages@gmail.com

On 06/05/2014 04:04 PM, Vivek Goyal wrote:
> On Wed, Jun 04, 2014 at 09:39:10PM +0200, Michael Kerrisk wrote:
>> Vivek,
>>
>> As per Documentation/SubmitChecklist , please CC linux-api@ on patces
>> that change the ABI/API. See
>> https://www.kernel.org/doc/man-pages/linux-api-ml.html.
> 
> Hi Michael,
> 
> Sorry, I did not notice that. I will CC linux-api@ in next version of
> patches in patches which introduce new systemcal..
> 
>>
>> Also, is there some draft man page for this new system call?
> 
> No, there is none yet. In fact I don't see a man page for old kexec
> system call either kexec_load().

Is this not what you are meaning:
http://man7.org/linux/man-pages/man2/kexec_load.2.html
?
(It probably could be improved...)

> Do you want me to write man page for this new syscall?

These days, that's considered a desirable accompaniment to new 
syscall proposals.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
