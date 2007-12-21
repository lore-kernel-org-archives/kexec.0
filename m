Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dub.bigfish.com ([213.199.154.10]
	helo=mail156-dub-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J5Wwj-00088v-Ei
	for kexec@lists.infradead.org; Fri, 21 Dec 2007 01:45:12 +0000
Message-ID: <476B1A46.6000207@am.sony.com>
Date: Thu, 20 Dec 2007 17:43:34 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [patch] kexec: Use target linker for purgatory
References: <476B05C0.30201@am.sony.com> <200712211028.23905.jk@ozlabs.org>
In-Reply-To: <200712211028.23905.jk@ozlabs.org>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On 12/20/2007 05:28 PM, Jeremy Kerr wrote:
> Geoff,
> 
>> Pugatory files need to be linked with the target linker,
>> not the build linker.
>>
>>  	$(MKDIR) -p $(@D)
>> -	$(LD) $(LDFLAGS) -o $@ $^
>> +	$(CC) $(LDFLAGS) -o $@ $^
> 
> Shouldn't that be $(TARGET_CC) then?

It follows the convention in that makefile.  There is this:

  $(PURGATORY): CC=$(TARGET_CC)

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
