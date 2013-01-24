Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TyORP-00015u-K0
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 15:10:12 +0000
Message-ID: <51014EC3.7070805@zytor.com>
Date: Thu, 24 Jan 2013 09:09:55 -0600
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: crashkernel reservation failed - No suitable area found
References: <51009722.40600@gmail.com> <20130124150722.GD3010@redhat.com>
In-Reply-To: <20130124150722.GD3010@redhat.com>
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
Cc: CAI Qian <caiqian@redhat.com>, Takashi Iwai <tiwai@suse.de>, Jay Lan <jay.zen.lan@gmail.com>, kexec@lists.infradead.org, xiyou.wangcong@gmail.com, Yinghai Lu <yinghai@kernel.org>

On 01/24/2013 09:07 AM, Vivek Goyal wrote:
>>
>> Is there a kernel/kexec-tools patch to address this problem in kernel 3.x
>> yet? Also, according to Takashi Iwa wrote, "the problem does not happen
>> always. However, once this happens, it continues to happen" :-(
>> Yes, yes, it drove me completely crazy trying to figure out how to get the
>> system out of this trapped state! Please help!
> 
> I thought Yinghai Lu worked on some patches to make 512MB reservation
> working again. Not sure where these patches are queued and when are
> they scheduled to be pushed into linus tree. 
> 
> hpa, yinghai should know more.
> 

Yes, I am working through what I'm *hoping* will be the final version
now.  If all goes well, they will probably be in -tip late tomorrow and
pushed into the 3.9 kernel.  If all *doesn't* go well, it depends on
what the hangups are.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
