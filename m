Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhNoV-0003Jv-Py
 for kexec@lists.infradead.org; Tue, 28 May 2013 17:36:00 +0000
Message-ID: <51A4EADB.9080703@zytor.com>
Date: Tue, 28 May 2013 10:35:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
References: <1369721851.2776.37@driftwood> <51A44DD5.5050301@cn.fujitsu.com>
 <1369761966.2776.39@driftwood>
In-Reply-To: <1369761966.2776.39@driftwood>
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
To: Rob Landley <rob@landley.net>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Simon Horman <horms@verge.net.au>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On 05/28/2013 10:26 AM, Rob Landley wrote:
>>
>> So, could I just use UNSED to replace OBSOLETE here? Or use
>> "OBSOLETE/UNUSED"?
> 
> Obsolete is fine.
> 
> Obsolete means it was used at some point, and thus reusing it might
> confuse or conflcit with legacy software. Unused could just mean that we
> left a gap for some reason, it doesn't imply it ever was used.
> 
> Explicitly documenting "unused" is kind of silly: all the ones we
> _don't_ document are presumably unused. Obsolete carries with it a very
> mild warning about legacy software, which is presumably why we still
> bother to mention it at all instead of just removing the entry.
> 
> (Then again the point was that nothing ever used this interface in the
> first place. Personally I'd just have removed the entry...)
> 

"Obsolete" in this specific context means that the reservation is
obsolete, but was used in kernels past, therefore the name and number
should not be reused to prevent old software from misbehaving.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
