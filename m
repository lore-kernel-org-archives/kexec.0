Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86] helo=ruth.realtime.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlR1S-0005Gt-GZ
	for kexec@lists.infradead.org; Tue, 08 May 2007 10:50:39 -0400
In-Reply-To: <20070508061338.GE8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE34.7070504@am.sony.com> <20070508061338.GE8170@verge.net.au>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <99b394986052b4a8627e4c893d16136d@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 4/5] Add proper node alignment for the powerpc device-tree
	cmdline.
Date: Tue, 8 May 2007 09:50:08 -0500
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>

On May 8, 2007, at 1:13 AM, Simon Horman wrote:
> On Mon, May 07, 2007 at 05:03:00PM -0700, Geoff Levand wrote:
>> Add proper node alignment for the powerpc device-tree cmdline.
>>
>> Fixes the runtime error 'Invalid tag 3a scanning flattened device 
>> tree !'.
>>
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>
> This seems ok to me, though I don't know much about the device tree.
>
> Milton, do you have any thoughts on this?
NACK

>> ---
>>  kexec/arch/ppc64/fs2dt.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> --- kexec-tools-hacked.orig/kexec/arch/ppc64/fs2dt.c
>> +++ kexec-tools-hacked/kexec/arch/ppc64/fs2dt.c
>> @@ -283,6 +283,10 @@ static void putprops(char *fn, struct di
>>  			strcat(local_cmdline, " ");
>>  			cmd_len = strlen(local_cmdline);
>>  			cmd_len = cmd_len + 1;
>> +			if ((cmd_len >= 8) && ((unsigned long)dt & 0x4)) {
>> +				fprintf(stderr, "Aligning cmdline %p\n", dt);
>> +				dt++;
>> +			}
>>  			memcpy(dt, local_cmdline,cmd_len);
>>  			len = cmd_len;
>>  			*dt_len = cmd_len;
>>
>> -- 
>>

That's only half the fix.  If the propety was > 8 and is now < 8
it might need to undo this alignment, but only if it was there
before.

Please change the code to behave like the initrd, where we skip the
property totally when copying, and then insert it at the end of the
directory.   That also handles the case where the source device-tree
doesn't have the property.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
