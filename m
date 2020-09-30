Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNgTU-0000Z3-CS
 for kexec@lists.infradead.org; Wed, 30 Sep 2020 18:05:09 +0000
Subject: Re: [PATCH v3] arm64: Add purgatory printing
References: <20200930103621.9497-1-matthias.bgg@kernel.org>
 <370ccb82-dccc-2109-061f-794546b95768@infradead.org>
From: Matthias Brugger <mbrugger@suse.com>
Message-ID: <16f21b1e-90ba-9ff9-5cb1-0834b70e3d9e@suse.com>
Date: Wed, 30 Sep 2020 20:04:57 +0200
MIME-Version: 1.0
In-Reply-To: <370ccb82-dccc-2109-061f-794546b95768@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>, matthias.bgg@kernel.org, kexec@lists.infradead.org, horms@verge.net.au
Cc: bhupesh.linux@gmail.com



On 30/09/2020 17:20, Geoff Levand wrote:
> Hi,
> 
> On 9/30/20 3:36 AM, matthias.bgg@kernel.org wrote:
>> --- a/kexec/arch/arm64/include/arch/options.h
>> +++ b/kexec/arch/arm64/include/arch/options.h
>>
>> +static uint64_t find_purgatory_sink(const char *console)
>> +{
>> +	int fd, ret;
>> +	char device[255], mem[255];
>> +	struct stat sb;
>> +	char buffer[10];
>> +	uint64_t iomem = 0x0;
>> +
>> +	if (!console)
>> +		return 0;
>> +
>> +	ret = snprintf(device, sizeof(device), "/sys/class/tty/%s", console);
>> +	if (ret < 0 || ret >= sizeof(device)) {
>> +		fprintf(stderr, "snprintf failed: %s\n", strerror(errno));
>> +		return 0;
>> +	}
>> +
>> +	if (stat(device, &sb) || !S_ISDIR(sb.st_mode)) {
>> +		fprintf(stderr, "kexec: %s: No valid console found for %s\n",
>> +			__func__, device);
>> +		return 0;
>> +	}
>> +
>> +	snprintf(mem, sizeof(mem), "%s%s", device, "/iomem_base");
>> +	if (ret < 0 || ret >= sizeof(mem)) {
> 
> Seems this is is just doing the same check again...
> 

Well we have to check snprintf outcome here again. Also sizeof(device) == 
sizeof(mem) we could have the case where the first snprintf fits into the 255 
character, while the second, where we add the "/iomem_base" does not.

Or didn't I understand you correctly?

Regards,
Matthias

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
