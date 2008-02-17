Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.syneticon.net ([213.239.212.131] helo=mail2.syneticon.net)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JQYXj-00071y-Pt
	for kexec@lists.infradead.org; Sun, 17 Feb 2008 01:42:16 +0000
Message-ID: <47B790DD.7090100@wpkg.org>
Date: Sun, 17 Feb 2008 02:41:49 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec tools mipsel port
References: <47B6CE01.60701@wpkg.org> <20080216163357.GA32373@verge.net.au>
	<47B74826.8090707@wpkg.org>
In-Reply-To: <47B74826.8090707@wpkg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: francesco.chiechi@colibre.it, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

Tomasz Chmielewski schrieb:

(...)

>>> There was a thread about kexec-tools mipsel port on Kexec Mailing 
>>> List  in June 2007.
>>>
>>> What's the current state of this patch?
>>>
>>> Is it working, will be merged, will not be merged?
>>
>> Its still very much in the state of needing someone to
>> nurse it into a merge.
> 
> Funny thing is, kernel supports kexec, but there is no userland support 
> for it (well, unless you patch kexec-tools with the patches you found 
> somewhere on the internet).
> 
> I'll try to see if the old patches posted to this list work for me.

Well, it's not very encouraging:


# kexec -l vmlinux-2.6.23.1
# kexec -e
Starting new kernel
Will call new kernel at 002ca000
Bye ...


And that's about it.

Do I need to specify mem-min and/or mem-max on mipsel?



-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
